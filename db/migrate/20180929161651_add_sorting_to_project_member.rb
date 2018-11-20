class AddSortingToProjectMember < ActiveRecord::Migration[5.2]
  def change
    add_column :project_members, :sorting, :integer
  end
end
