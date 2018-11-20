class RemoveStepIdFrom < ActiveRecord::Migration[5.2]
  def change
    remove_column :requirements, :step_id, :integer
  end
end
