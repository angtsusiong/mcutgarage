class AddIsActiveToProjectCategory < ActiveRecord::Migration[5.2]
  def change
    add_column :project_categories, :is_active, :boolean
  end
end
