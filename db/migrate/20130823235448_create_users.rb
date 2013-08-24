class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.boolean :cell_show
      t.string :cell_number
      t.boolean :email_show
      t.boolean :home_phone_show
      t.string :home_phone
      t.string :password_digest
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :postal
      t.string :qrcode

      t.timestamps
    end
  end
end
