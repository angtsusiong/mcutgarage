class FixRequirementTypo < ActiveRecord::Migration[5.2]
  def change
    remove_column :requirements, :miximum
    add_column :requirements, :maximum, :integer
  end
end
