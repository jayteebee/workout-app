class WorkoutScheduleRegenerationJob
include Sidekiq::Worker

def perform
    User.find_each do |user|
        WorkoutScheduleGenerator.new(user).generate
    end
end
end