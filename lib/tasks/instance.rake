namespace :instance do
	Rails.logger = Logger.new(STDOUT)

  desc 'Add default instance'
  task :add_default_instance => :environment do
    path = File.join(Rails.root, 'config', 'instance.yml')
    config = File.exists?(path) ? YAML::load_file(File.open(path))[Rails.env] : {}

    Instance.create! name: config['name'], url: config['url'], end_point: config['end_point'], default: true
  end

end
