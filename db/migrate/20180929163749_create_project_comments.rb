class CreateProjectComments < ActiveRecord::Migration[5.2]
  def change
    create_table :project_comments do |t|
      t.integer :user_id
      t.integer :project_id
      t.text :content
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
