class AddColumnToMessage < ActiveRecord::Migration
  def change
    remove_column :messages, :text
    add_column  :messages, :text, :text
  end
end
