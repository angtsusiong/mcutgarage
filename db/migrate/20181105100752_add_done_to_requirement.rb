class AddDoneToRequirement < ActiveRecord::Migration[5.2]
  def change
    add_column :requirements, :done, :boolean
  end
end
