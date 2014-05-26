class AddDeafultValueForPriority < ActiveRecord::Migration
  def up
    change_column :tasks, :priority, :integer, default: 0
  end

  def down
    change_column :tasks, :priority, :integer, default: nil
  end
end
