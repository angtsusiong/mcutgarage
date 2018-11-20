class RemoveColumnStep < ActiveRecord::Migration[5.2]
  def change
    remove_column :steps, :priority
    remove_column :steps, :activity_id
  end
end
