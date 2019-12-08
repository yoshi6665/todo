class Task < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :title, presence: true
  validates :priority, presence: true


  enum status: {
    undo: 10,
    in_progress: 20,
    done: 30,
  }

  enum priority: {
    high: 10,
    low: 20,
  }

  def self.search(search,search_start_date1,search_start_date2)
    if search
      where(['title LIKE ? OR description LIKE ?', "%#{search}%","%#{search}%"])
    else
      all
    end

    if search_start_date1 || search_start_date2
      where(:date => search_start_date1..search_start_date2)
    else
      all
    end
  end
end
