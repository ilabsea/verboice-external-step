class Instance
  include ActiveModel::Model

  attr_accessor :name, :url, :end_point

  def self.default
    Instance.new name: Instance.config['name'], url: Instance.config['url'], end_point: Instance.config['end_point']
  end

  def self.config
    path = File.join(Rails.root, 'config', 'instance.yml')
    @@config ||= File.exists?(path) ? YAML::load(File.open(path))[Rails.env] : {}
  end

end

