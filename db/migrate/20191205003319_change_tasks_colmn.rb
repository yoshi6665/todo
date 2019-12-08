class ChangeTasksColmn < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :status,:integer, default:Task.statuses[:undo]
  end
end
