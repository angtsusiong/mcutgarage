class CreateJoinTableActivityStep < ActiveRecord::Migration[5.2]
  def change
    create_join_table :activities, :steps do |t|
      t.index [:activity_id, :step_id]
      t.index [:step_id, :activity_id]
      t.integer :priority
    end
  end
end
