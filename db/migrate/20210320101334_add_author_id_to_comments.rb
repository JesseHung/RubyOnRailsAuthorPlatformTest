class AddAuthorIdToComments < ActiveRecord::Migration[6.1]
  def change
    add_reference :comments, :author, null: false, foreign_key: true
  end
end
