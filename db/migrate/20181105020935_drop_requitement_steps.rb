class DropRequitementSteps < ActiveRecord::Migration[5.2]
  def change
    drop_table :requirements_steps
    create_join_table :requirements, :steps do |t|
      t.index [:requirement_id, :step_id]
      t.index [:step_id, :requirement_id]
    end
  end
end
