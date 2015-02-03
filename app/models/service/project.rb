class Service::Project < ActiveApi
  attribute :id, Integer
  attribute :name, String

  def self.collection
    all.map { |project| [project.name, project.id] }
  end

  def self.fetch id
  	where(id: id).first
  end

end
