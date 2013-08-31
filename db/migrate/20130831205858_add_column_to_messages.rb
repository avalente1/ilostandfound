class AddColumnToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :complete, :boolean, default:
  end
end
