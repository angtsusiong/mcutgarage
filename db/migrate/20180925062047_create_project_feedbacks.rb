class CreateProjectFeedbacks < ActiveRecord::Migration[5.2]
  def up
    create_table :project_feedbacks do |t|
      t.integer :project_id
      t.string :version
      t.text :content
      t.belongs_to :project, index: true

      t.timestamps
    end
  end

  def down
    drop_table :project_feedbacks
  end

end
