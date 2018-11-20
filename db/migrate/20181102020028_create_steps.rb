class CreateSteps < ActiveRecord::Migration[5.2]
  def change
    create_table :steps do |t|
      t.integer :project_id
      t.string :name
      t.integer :priority
      t.text :desc

      t.timestamps
    end
  end
end
