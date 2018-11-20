class CreateProjectDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :project_details do |t|
      t.integer :project_id
      t.integer :requirement_id
      t.text :desc

      t.timestamps
    end
  end
end
