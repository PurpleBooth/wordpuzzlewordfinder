config_file = Rails.root.join('config/mongo.yml')
if config_file.file?
  config = YAML.load(ERB.new(config_file.read).result)
  MongoMapper.setup(config, Rails.env, :logger => Rails.logger)
end

if defined?(PhusionPassenger)
  PhusionPassenger.on_event(:starting_worker_process) do |forked|
    MongoMapper.connection.connect if forked
  end
end

