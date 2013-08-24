class AddDeliveryXml < ActiveRecord::Migration
  def change
    add_column :users, :delivery_options, :text
  end
end
