class Task < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :title, presence: true
  validates :priority, presence: true
end
