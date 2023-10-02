class WorkoutScheduleRegenerationJob
include Sidekiq::Worker
sidekiq_options queue: 'default', retry: false


def perform(user_id, routine_id)
    user = User.find_by(id: user_id)
    return unless user && routine_id
        WorkoutScheduleGenerator.new(user).generate_schedules(routine_id)
    end
end
