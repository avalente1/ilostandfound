class AddColumnToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :complete, :boolean, default: false
  end
end
