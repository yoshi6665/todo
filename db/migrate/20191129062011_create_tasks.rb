class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.date :start_date
      t.date :finish_schedule_date
      t.date :finish_date
      t.string :priority
      t.string :status
      t.integer :user_id


      t.timestamps
    end
  end
end
