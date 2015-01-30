class Service::Project < ActiveApi
  attribute :id, Integer
  attribute :name, String

  @@projects = []

  def self.collection
  	fetch_all.map { |project| [project.name, project.id] }
  end

  def self.fetch_all
  	@@projects = all
  end

  def self.fetch id
  	@@projects.select { |project| project if project.id == id } .first
  end

end
