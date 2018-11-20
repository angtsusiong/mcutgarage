class CreateRequirements < ActiveRecord::Migration[5.2]
  def change
    create_table :requirements do |t|
      t.integer :step_id
      t.string :name
      t.integer :datatype
      t.text :desc
      t.integer :minimum
      t.integer :miximum

      t.timestamps
    end
  end
end
