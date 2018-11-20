class CreateProjectsUsers < ActiveRecord::Migration[5.2]
  def up
    create_table :projects_users do |t|
      t.integer :project_id
      t.integer :user_id
      t.belongs_to :project, index: true
      t.belongs_to :user, indes: true

      t.timestamps
    end
  end

  def down
    drop_table :projects_users
  end

end
