require "sidekiq"
require "sidekiq-cron"

Sidekiq::Cron::Job.create(
    name: "WorkoutSchedule regeneration - every day",
    cron: "0 0 * * *",
    class: "WorkoutScheduleRegenerationJob"
)

Sidekiq::Cron::Job.create(
    name: "WorkoutSchedule Frequency regeneration - every day",
    cron: "0 0 * * *",
    class: "WorkoutScheduleFrequencyRegenerationJob" 
)