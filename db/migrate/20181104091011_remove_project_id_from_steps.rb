class RemoveProjectIdFromSteps < ActiveRecord::Migration[5.2]
  def change
    remove_column :steps, :project_id, :integer
    add_column :steps, :activity_id, :integer
  end
end
