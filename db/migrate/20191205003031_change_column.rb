class ChangeColumn < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :,:integer, default:Task.statuses[:undo]
  end
end
