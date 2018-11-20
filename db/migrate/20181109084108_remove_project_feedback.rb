class RemoveProjectFeedback < ActiveRecord::Migration[5.2]
  def change
    drop_table :project_feedbacks
  end
end
