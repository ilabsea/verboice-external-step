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
	ILO_RATING = 'ilo_rating'
  NOTIFY_RATING = 'notify_rating'

  def self.type(name:)
    step_name = name.camelize
    "Steps::#{step_name}".constantize
  end

  def clear_ratings
    IloRating.destroy_all(step_id: id)
  end

end
