class CreateProjectBadges < ActiveRecord::Migration[5.2]
  def up
    create_table :project_badges do |t|
      t.integer :project_id
      t.string :title
      t.integer :status
      t.belongs_to :project, index: true

      t.timestamps
    end
  end

  def down
    drop_table :project_badges
  end

end
