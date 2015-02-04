class Step < ActiveRecord::Base
	validates :name, :display_name, :url, presence: true
	validates :name, uniqueness: true
	validates_format_of :url, with: URI.regexp

	has_many :variables, class_name: StepVariable, dependent: :destroy
  has_many :step_permissions, dependent: :destroy

	accepts_nested_attributes_for :variables

  before_destroy :clear_ratings

	DETECT_MOBILE_OPERATOR = 'detect_mobile_operator'
  DATE = 'DATE'
	PERIOD_RATING = 'period_rating'
  STORE_PERIOD_RATING = 'store_period_rating'
  NEW_CALLER = 'new_caller'

  def self.type(name:)
    step_name = name.camelize
    "Steps::#{step_name}".constantize
  end

  def clear_ratings
    PeriodRating.destroy_all(step_id: id)
  end

end
