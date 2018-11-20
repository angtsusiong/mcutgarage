class AddTypingToProjectsUser < ActiveRecord::Migration[5.2]
  def change
    add_column :projects_users, :typing, :integer
  end
end
