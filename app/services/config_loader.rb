class ConfigLoader
  def self.load(config_name, environment = Rails.env)
    loader = new(config_name)

    if block_given?
      loader.load(environment) { |config| yield config }
    else
      loader.load(environment)
    end
  end

  attr_reader :relative_path

  def initialize(config_name)
    @relative_path = File.join('config', "#{config_name}.yml").to_s
  end

  def load(environment)
    Rails.logger.warn("Config file #{relative_path} is missing.") unless config_file_present?

    config = load_config_data.fetch(environment.to_s)

    if block_given?
      yield config
    else
      config
    end
  end

  private

  def load_config_data
    (YAML.load(ERB.new(load_config_file).result) || {}).stringify_keys # rubocop:disable Security/YAMLLoad
  end

  def load_config_file
    File.new(absolute_path).read
  end

  def config_file_present?
    File.file?(absolute_path)
  end

  def absolute_path
    @absolute_path ||= Rails.root.join(relative_path).to_s
  end
end
