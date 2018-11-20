class FixProject < ActiveRecord::Migration[5.2]
  def change
    remove_column :projects, :project_categories_id
  end
end
