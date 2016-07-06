class AddUndoneColumnToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :undone, :string, default: "Not Done" 
  end
end
