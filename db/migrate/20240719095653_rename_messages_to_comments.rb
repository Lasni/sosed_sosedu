class RenameMessagesToComments < ActiveRecord::Migration[7.1]
  def change
    rename_table :messages, :comments
  end
end
