class AddActivitiesRefToSteps < ActiveRecord::Migration[5.2]
  def change
    remove_column :steps, :activity_id
    add_reference :steps, :activity
  end
end
