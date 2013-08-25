class CreatePoint < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.integer :user_id
      t.integer :points
    end
    add_column :users, :point_tally, :integer, default: 0
  end
end
