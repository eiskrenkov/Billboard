require_relative 'boot'
require 'rails/all'

Bundler.require(*Rails.groups)

# rubocop:disable Style/ClassAndModuleChildren
module Billboard
  class Application < Rails::Application
    config.load_defaults 6.0

    # Sidekiq for Active Job
    config.active_job.queue_adapter = :sidekiq

    config.autoload_paths += %w[
      app/enumerations
    ].map { |path| File.join config.root, path }

    config.generators do |g|
      g.template_engine :slim
    end
  end
end
# rubocop:enable Style/ClassAndModuleChildren
