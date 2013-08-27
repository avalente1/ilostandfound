class AddToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :latitude, :float
    add_column :messages, :longitude, :float
    add_column :messages, :current, :boolean, default: true
    add_column :messages, :ip_address, :string
  end
end
