class ChangePriority < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks,:priority,:integer
  end
end
