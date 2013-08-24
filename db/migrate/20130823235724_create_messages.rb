class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :find_id
      t.integer :owner_id
      t.string :text
      t.string :subject

      t.timestamps
    end
  end
end
