class CreateProjectVerifications < ActiveRecord::Migration[5.2]
  def change
    create_table :project_verifications do |t|
      t.text :feedback
      t.boolean :result
      t.belongs_to :project, foreign_key: true
      t.belongs_to :step, foreign_key: true

      t.timestamps
    end
  end
end
