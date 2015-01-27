class Instance < ActiveRecord::Base
  validates :name, :url, :end_point, :default, presence: true
  validates_uniqueness_of :url, :end_point
  validates_format_of :url, :end_point, with: URI.regexp

  @@default = nil

  MINIMUM = 1 # must be at least one

  def self.default
  	@@default = where(default: true).first if @@default.nil?
  	@@default
  end

end
