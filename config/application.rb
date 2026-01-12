# frozen_string_literal: true

require_relative 'boot'

require 'rails'

require 'active_model/railtie'
require 'active_job/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_dispatch/railtie'
require 'mongoid'

Bundler.require(*Rails.groups)

module Store
  class Application < Rails::Application
    config.load_defaults 7.1

    config.api_only = true

    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore,
                          key: '_store_session',
                          same_site: :lax

    config.generators do |g|
      g.orm :mongoid
    end

    Mongoid.load!(Rails.root.join('config/mongoid.yml'), Rails.env)

    config.active_job.queue_adapter = :sidekiq
  end
end
