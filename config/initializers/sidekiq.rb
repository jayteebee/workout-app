require "sidekiq"
require "sidekiq-cron"

Sidekiq::Cron::Job.create(
    name: "WorkoutSchedule regeneration - every day",
    cron: "*/5 * * * *",
    class: "WorkoutScheduleRegenerationJob"
)