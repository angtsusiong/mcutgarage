class CreateProjectMembers < ActiveRecord::Migration[5.2]
  def up
    create_table :project_members do |t|
      t.integer :project_id
      t.integer :user_id
      t.string :job_title
      t.text :brief_intro
      t.boolean :is_leader
      t.belongs_to :project, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end

  def down
    drop_table :project_members
  end

end
