class AddCategoryToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :project_category_id, :integer, index: true
  end
end
