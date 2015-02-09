class PeriodRating < ActiveRecord::Base
  validates :code, :step_id, :from_date, :to_date, presence: true
  serialize :numbers, Array

  belongs_to :step

  validates :code, uniqueness: true
  validates :code, numericality: { greater_than: 0, less_than: 100 }

  validate :from_date_must_be_less_than_to_date
  validate :unique_date_range

  SEPERATOR = ","
  SEPERATOR_DISPLAY = ", "

  NON_EXISTING_OR_RATED = -1

  class << self
    def get_code_of(date, tel)
      period_rating_code = NON_EXISTING_OR_RATED

      rating = get date
      if rating
        period_rating_code = rating.code unless rating.has_telephone?(tel)
      end

      period_rating_code
    end

    def get(date)
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

  def from_date_must_be_less_than_to_date
    errors.add(:date, 'to_date must be greater than from_date') if from_date > to_date
  end

  def unique_date_range
    PeriodRating.where.not(id: self.id).each do |rating|
      if rating.in_range? from_date, to_date
        errors.add(:date, 'date range already exists')
      end
    end
  end

  def exist?(tel, date)
    found = false

    if has_date?(date)
      if has_telephone?(tel)
        found = true
      end
    end

    found
  end

  def in_range? first_date, second_date
    first_date.between?(from_date, to_date) || (first_date.less_than_or_equal?(from_date) && second_date.greater_than_or_equal?(from_date))
  end

  def has_date? date
    date.between?(from_date, to_date)
  end

  def has_telephone? tel
    numbers.include?(tel.without_prefix)
  end

  def sync_numbers_with!(project_id, variable_id)
    is_modified = false

    call_log_answers = Service::CallLogAnswer.fetch_by project_id, variable_id, from_date.to_string('%Y-%m-%d'), (to_date + 1.day).to_string('%Y-%m-%d')
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
