class CreateQrcodes < ActiveRecord::Migration
  def change
    create_table :qrcodes do |t|
      t.integer :user_id
      t.string :cover_image_uid

      t.timestamps
    end
  end
end
