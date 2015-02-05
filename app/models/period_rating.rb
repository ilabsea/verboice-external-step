class PeriodRating < ActiveRecord::Base
  validates :code, :step_id, presence: true
  serialize :numbers, Array

  belongs_to :step

  validates :code, uniqueness: true
  validates :code, numericality: { greater_than: 0, less_than: 100 }

  attr_accessor :client_from_date, :client_to_date, :addresses

  validates :client_from_date, :"validator/date" => { date_format: Date::DEFAULT_FORMAT, field: :from_date }, if: Proc.new { |record| record.new_record? }
  validates :client_to_date, :"validator/date" => { date_format: Date::DEFAULT_FORMAT, field: :to_date }, if: Proc.new { |record| record.new_record? }

  validate :unique_date_range, on: :create

  SEPERATOR = ","
  SEPERATOR_DISPLAY = ", "

  NON_EXISTING_OR_RATED = -1

  class << self
    def get_code_of(date:, tel:)
      period_rating_code = NON_EXISTING_OR_RATED

      rating = get date: date
      if rating
        period_rating_code = rating.code unless rating.has_telephone?(tel)
      end

      period_rating_code
    end

    def get(date:)
      rating = nil

      all.each do |r|
        if r.has_date? date
          rating = r 
          break
        end
      end

      rating
    end
  end

  def unique_date_range
    if client_from_date.present? && client_to_date.present?
      self.from_date = Parser::DateParser.parse(client_from_date)
      self.to_date = Parser::DateParser.parse(client_to_date)
      PeriodRating.all.each do |rating|
        if rating.from_date.between?(from_date, to_date) || rating.to_date.between?(from_date, to_date)
          errors.add(:date, 'date range already exists')
        end
      end
    end
  end

  def exist?(tel:, date:)
    found = false

    if has_date?(date)
      if has_telephone?(tel)
        found = true
      end
    end

    found
  end

  def has_date? date
    date.between?(from_date, to_date)
  end

  def has_telephone? tel
    numbers.include?(tel.without_prefix)
  end

  def addresses
    @addresses
  end

  def addresses=(val)
    @addresses = val
  end

  def client_from_date
    @client_from_date
  end

  def client_from_date=(val)
    @client_from_date = val
  end

  def client_to_date
    @client_to_date
  end

  def client_to_date=(val)
    @client_to_date = val
  end

  def sync_numbers_with!(project_id:, variable_id:)
    is_modified = false

    call_log_answers = Service::CallLogAnswer.fetch_by project_id: project_id, variable_id: variable_id, from: from_date.to_string('%Y-%m-%d'), to: (to_date + 1.day).to_string('%Y-%m-%d')
    call_log_answers.each do |answer|
      if answer.value
        is_modified = true
        number_without_voip = answer.call_log[:prefix_called_number] ? answer.call_log[:address][answer.call_log[:prefix_called_number].length..-1] : answer.call_log[:address]
        tel = Tel.new number_without_voip
        register! tel
      end
    end

    save if is_modified

  end

  def register! tel
    unless has_telephone?(tel)
      numbers.push tel.without_prefix
      save
    end
  end
end
