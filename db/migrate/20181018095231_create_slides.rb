class CreateSlides < ActiveRecord::Migration[5.2]
  def change
    create_table :slides do |t|
      t.string :name
      t.text :desc

      t.timestamps
    end
  end
end
