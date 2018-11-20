class AddPublicToActivitiesStep < ActiveRecord::Migration[5.2]
  def change
    add_column :activities_steps, :public, :boolean
  end
end
