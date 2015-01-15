class Operator
  path = File.join(Rails.root, 'config', 'mobile_operator.yml')
  # path = File.expand_path("#{Rails.root}/config/mobile_operator.yml", __FILE__)
  @@operators = File.exists?(path) ? YAML::load(File.open(path)) : {}

  def self.list
    @@operators['operators'].nil? ? [] : @@operators['operators']
  end

  def self.codes
    @@operators['codes'].nil? ? {} : @@operators['codes']
  end

end