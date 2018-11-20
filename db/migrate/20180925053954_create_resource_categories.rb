class CreateResourceCategories < ActiveRecord::Migration[5.2]
  def up
    create_table :resource_categories do |t|
      t.string :name

      t.timestamps
    end
  end

  def down
    drop_table :resource_categories
  end

end
