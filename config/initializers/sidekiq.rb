# frozen_string_literal: true

require 'sidekiq'
require 'sidekiq-cron'

Sidekiq.configure_server do |_config|
  schedule_file = 'config/sidekiq.yml'

  if File.exist?(schedule_file)
    schedule = begin
      YAML.load_file(schedule_file)['scheduler']['schedule']
    rescue StandardError
      {}
    end
    Sidekiq::Cron::Job.load_from_hash(schedule) unless schedule.empty?
  end
end
