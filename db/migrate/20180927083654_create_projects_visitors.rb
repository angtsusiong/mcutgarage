class CreateProjectsVisitors < ActiveRecord::Migration[5.2]
  def change
    create_table :project_visitors do |t|
      t.integer :project_id
      t.string :ip_address
      t.belongs_to :project

      t.timestamps
    end
  end
end
