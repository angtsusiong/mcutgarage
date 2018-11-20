class RemoveIsLeaderFromProjectMember < ActiveRecord::Migration[5.2]
  def change
    remove_column :project_members, :is_leader
  end
end
