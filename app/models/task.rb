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

  def self.search(search)
    keyword = search[:search]
    start_from = search[:start_from]
    start_to = search[:start_to]
    finish_schedule_from = search[:finish_schedule_from]
    finish_schedule_to = search[:finish_schedule_to]
    status = search[:status]
    priority = search[:priority]
    sort = search[:sort]
    tasks = Task.all
    tasks = tasks.where(['title LIKE ? OR description LIKE ?', "%#{keyword}%","%#{keyword}%"]) if keyword.present?
    tasks = tasks.where("start_date >= ?", start_from) if start_from.present?
    tasks = tasks.where("start_date <= ?", start_to) if start_to.present?
    tasks = tasks.where(status: status) if status.present?
    tasks = tasks.where(priority: priority) if priority.present?
    tasks = tasks.where("finish_schedule_date >= ?", finish_schedule_from) if finish_schedule_from.present?
    tasks = tasks.where("finish_schedule_date <= ?", finish_schedule_to) if finish_schedule_to.present?
    if sort = "1"
      tasks=tasks.order(['field(id,?)',ids])
    elsif sort = "2"
      tasks=Task.order(['field()']) :yomi
    elsif sort = "3"
      tasks=Task.order(status: "DESC")
    elsif sort = "4"
       tasks=Task.order(priority: "DESC")
    elsif sort = "5"
       tasks=Task.order(start_date: "DESC")
    elsif sort = "6"
      tasks=Task.order(finish_schedule_date: "DESC")
    elsif sort = "7"
       tasks=Task.order(finish_date: "DESC")
    end
    tasks
  end

end
