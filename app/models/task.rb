class Task < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :title, presence: true
  validates :priority, presence: true


  enum status: {
    未着手: 10,
    作業中: 20,
    完了: 30,
  }

  enum priority: {
    高: 10,
    低: 20,
  }

  def self.search(search)
    keyword = search[:keyword]
    start_from = search[:start_from]
    start_to = search[:start_to]
    finish_schedule_from = search[:finish_schedule_from]
    finish_schedule_to = search[:finish_schedule_to]
    status = search[:status]
    priority = search[:priority]
    sort = search[:sort]
    updown = search[:updown]
    tasks = Task.all
    tasks = tasks.where(['title LIKE ? OR description LIKE ?', "%#{keyword}%","%#{keyword}%"]) if keyword.present?
    tasks = tasks.where("start_date >= ?", start_from) if start_from.present?
    tasks = tasks.where("start_date <= ?", start_to) if start_to.present?
    tasks = tasks.where(status: status) if status.present?
    tasks = tasks.where(priority: priority) if priority.present?
    tasks = tasks.where("finish_schedule_date >= ?", finish_schedule_from) if finish_schedule_from.present?
    tasks = tasks.where("finish_schedule_date <= ?", finish_schedule_to) if finish_schedule_to.present?
    tasks = tasks.order(id: "DESC") if sort == "作成順" && updown == "降順"
    tasks = tasks.order(id: "ASC") if sort == "作成順" && updown == "昇順"
    tasks = tasks.order(title: "DESC") if sort == "名前順" && updown == "降順"
    tasks = tasks.order(title: "ASC") if sort == "名前順" && updown == "昇順"
    tasks = tasks.order(status: "DESC") if sort == "ステータス" && updown == "降順"
    tasks = tasks.order(status: "ASC") if sort == "ステータス" && updown == "昇順"
    tasks = tasks.order(priority: "DESC") if sort == "優先度" && updown == "降順"
    tasks = tasks.order(priority: "ASC") if sort == "優先度" && updown == "昇順"
    tasks = tasks.order(start_date: "DESC") if sort == "作業開始日" && updown == "降順"
    tasks = tasks.order(start_date: "ASC") if sort == "作業開始日" && updown == "昇順"
    tasks = tasks.order(finish_schedule_date: "DESC") if sort == "作業終了予定日" && updown == "降順"
    tasks = tasks.order(finish_schedule_date: "ASC") if sort == "作業終了予定日" && updown == "昇順"
    tasks = tasks.order(finish_date: "DESC") if sort == "作業終了日" && updown == "降順"
    tasks = tasks.order(finish_date: "ASC") if sort == "作業終了日" && updown == "昇順"
    tasks
  end
end
