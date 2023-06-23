require "sidekiq"
require "sidekiq-cron"

Sidekiq::Cron::Job.create(
    name: "WorkoutSchedule regeneration - every day",
    cron: "0 0 * * *",
    class: "WorkoutScheduleRegenerationJob"
)