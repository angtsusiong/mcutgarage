class CreateBadgesProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :badges do |t|
      t.string :name

      t.timestamps
    end

    create_table :badges_projects do |t|
      t.references :project
      t.references :badge

      t.timestamps
    end

    add_index(:badges, :name)
    add_index(:badges_projects, [ :project_id, :badge_id ])
  end
end
