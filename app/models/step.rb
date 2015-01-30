class Step < ActiveRecord::Base
	validates :name, :display_name, :url, presence: true
	validates :name, uniqueness: true
	validates_format_of :url, with: URI.regexp

	has_many :variables, class_name: StepVariable, dependent: :destroy

	accepts_nested_attributes_for :variables

	DETECT_MOBILE_OPERATOR = 'detect_mobile_operator'
	ILO_RATING = 'ilo_rating'

  def self.type(name:)
    step_name = name.camelize
    "Steps::#{step_name}".constantize
  end

end
