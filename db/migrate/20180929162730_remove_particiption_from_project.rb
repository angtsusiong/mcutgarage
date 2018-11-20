class RemoveParticiptionFromProject < ActiveRecord::Migration[5.2]
  def change
    remove_column :projects, :participation, :string
  end
end
