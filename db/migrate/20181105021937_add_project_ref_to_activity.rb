class AddProjectRefToActivity < ActiveRecord::Migration[5.2]
  def change
    remove_column :activities, :project_id
    add_reference :activities, :project, foreign_key: true
  end
end
