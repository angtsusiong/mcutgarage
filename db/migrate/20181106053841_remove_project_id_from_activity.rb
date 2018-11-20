class RemoveProjectIdFromActivity < ActiveRecord::Migration[5.2]
  def change
    remove_column :activities, :project_id, :bigint
    remove_column :projects, :abstract, :text
    remove_column :projects, :content, :text
    remove_column :projects, :idea_origin, :text
    remove_column :projects, :team_intro, :text
    add_column :activities, :desc, :text
  end
end
