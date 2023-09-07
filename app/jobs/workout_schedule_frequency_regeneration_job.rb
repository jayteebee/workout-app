class WorkoutScheduleFrequencyRegenerationJob
    include Sidekiq::Worker
    sidekiq_options queue: 'default', retry: true
    
    
    def perform(user_id, routine_id)
        user = User.find_by(id: user_id)
        return unless user
            WorkoutScheduleFrequencyGenerator.new(user).generate_schedules(routine_id)
        end
    end