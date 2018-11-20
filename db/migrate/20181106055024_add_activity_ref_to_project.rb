class AddActivityRefToProject < ActiveRecord::Migration[5.2]
  def change
    add_reference :projects, :activity, foreign_key: true
  end
end
