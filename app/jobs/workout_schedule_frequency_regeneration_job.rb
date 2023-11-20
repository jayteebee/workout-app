class WorkoutScheduleFrequencyRegenerationJob
    include Sidekiq::Worker
    sidekiq_options queue: 'default', retry: false
    
    def perform(user_id, routine_id)
        return unless user_id && routine_id

        user = User.find_by(id: user_id)
            WorkoutScheduleFrequencyGenerator.new(user).generate_schedules(routine_id)
        end
    end