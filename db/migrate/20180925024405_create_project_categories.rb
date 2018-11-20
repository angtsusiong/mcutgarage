class CreateProjectCategories < ActiveRecord::Migration[5.2]
  def up
    create_table :project_categories do |t|
      t.string :name
      t.text :brif_intro
      t.timestamps
    end

    def down
      drop_table :project_categories
    end

  end
end
