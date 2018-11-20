class CreateArticles < ActiveRecord::Migration[5.2]
  def up
    create_table :articles do |t|
      t.integer :user_id
      t.string :title
      t.text :content
      t.integer :status
      t.belongs_to :user, index: true

      t.timestamps
    end
  end

  def down
    drop_table :articles
  end

end
