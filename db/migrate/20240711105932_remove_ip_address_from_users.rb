class RemoveIpAddressFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :ip_address, :string
  end
end
