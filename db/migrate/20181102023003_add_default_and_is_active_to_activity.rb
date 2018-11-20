class AddDefaultAndIsActiveToActivity < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :default, :boolean
    add_column :activities, :is_active, :boolean
  end
end
