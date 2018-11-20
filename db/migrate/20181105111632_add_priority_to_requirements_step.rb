class AddPriorityToRequirementsStep < ActiveRecord::Migration[5.2]
  def change
    add_column :requirements_steps, :priority, :integer
  end
end
