class AddRefProject < ActiveRecord::Migration[5.2]
  def change
    remove_column :projects, :project_category_id
    add_reference :projects, :project_category, foreign_key: true
  end
end
