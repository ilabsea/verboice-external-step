class Service::Project < ActiveApi
  attribute :id, Integer
  attribute :name, String

  def self.collection
    all.map { |project| [project.name, project.id] }
  end

  def self.fetch id
    project = nil

    all.each do |p|
      if p.id == id
        project = p 
        break
      end
    end

    project
  end

end
