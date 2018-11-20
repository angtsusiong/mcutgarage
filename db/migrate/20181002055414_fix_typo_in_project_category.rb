class FixTypoInProjectCategory < ActiveRecord::Migration[5.2]
  def change
    remove_column :project_categories, :brif_intro
    add_column :project_categories, :brief_intro, :text
  end
end
