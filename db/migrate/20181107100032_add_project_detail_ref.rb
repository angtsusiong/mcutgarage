class AddProjectDetailRef < ActiveRecord::Migration[5.2]
  def change
    remove_column :project_details, :project_id
    remove_column :project_details, :desc
    remove_column :project_details, :requirement_id
    add_reference :project_details, :project, foreign_key: true
    add_reference :project_details, :requirement, foreign_key: true
    add_column :project_details, :content, :text
  end
end
