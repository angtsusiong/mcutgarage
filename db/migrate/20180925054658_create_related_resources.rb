class CreateRelatedResources < ActiveRecord::Migration[5.2]
  def up
    create_table :related_resources do |t|
      t.integer :resources_category_id
      t.string :title
      t.text :content
      t.belongs_to :resources_category, index: true
      t.string :url

      t.timestamps
    end
  end

  def down
    drop_table :related_resources
  end

end
