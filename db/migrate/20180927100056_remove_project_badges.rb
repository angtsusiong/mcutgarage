class RemoveProjectBadges < ActiveRecord::Migration[5.2]
  def change
    drop_table :project_badges
  end
end
