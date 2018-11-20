class AddPhoneAndTokenAndSelfIntroToUser < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :phone, :string
    add_column :users, :token, :string
    add_column :users, :self_intro, :text
  end

  def down
    remove_column :users, :phone
    remove_column :users, :token
    remove_column :users, :self_intro
  end

end
