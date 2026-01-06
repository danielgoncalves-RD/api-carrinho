require 'sidekiq'
require 'sidekiq-cron'

Sidekiq.configure_server do |config|
  schedule_file = "config/sidekiq.yml"

  if File.exist?(schedule_file)
    schedule = YAML.load_file(schedule_file)['scheduler']['schedule'] rescue {}
    Sidekiq::Cron::Job.load_from_hash(schedule) unless schedule.empty?
  end
end