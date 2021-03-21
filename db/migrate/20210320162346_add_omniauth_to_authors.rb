class AddOmniauthToAuthors < ActiveRecord::Migration[6.1]
  def change
    add_column :authors, :fb_uid, :string
    add_column :authors, :fb_token, :string

    add_index :authors, :fb_uid
  end
end
