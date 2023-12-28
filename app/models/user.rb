class User < ApplicationRecord
    include Devise::JWT::RevocationStrategies::JTIMatcher

    devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable,
    :jwt_authenticatable, jwt_revocation_strategy: self

    validates_format_of :email, with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a valid email address"
    validates :email, uniqueness: true
    
    has_many :routines
    has_many :workouts
    has_many :workout_days
    has_many :workout_schedules
    has_many :session_logs
end
