class SessionLog < ApplicationRecord
  belongs_to :user
  serialize :details, Hash
end
