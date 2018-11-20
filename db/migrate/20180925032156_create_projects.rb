class CreateProjects < ActiveRecord::Migration[5.2]
  def up
    create_table :projects do |t|
      t.belongs_to :project_categories, index: true
      t.integer :category_id
      t.text :abstract
      t.text :content
      t.text :idea_origin
      t.string :name
      t.integer :participation
      t.integer :status
      t.text :team_intro

      t.timestamps
    end
  end

  def down
    drop_table :projects
  end

end
