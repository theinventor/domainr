class AddIpToDomain < ActiveRecord::Migration
  def change
    add_column :domains, :ip_address, :string
  end
end
