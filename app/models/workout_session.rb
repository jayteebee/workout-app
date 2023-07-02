class WorkoutSession < ApplicationRecord
  belongs_to :workout
  belongs_to :user
  has_many :exercise_sessions


  def as_json(options={})
    super(options.merge(include: :exercise_sessions))
  end
end
