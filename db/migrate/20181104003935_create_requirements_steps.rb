class CreateRequirementsSteps < ActiveRecord::Migration[5.2]
  def change
    create_table :requirements_steps do |t|
      t.integer :step_id
      t.integer :requirement_id

      t.timestamps
    end
  end
end
