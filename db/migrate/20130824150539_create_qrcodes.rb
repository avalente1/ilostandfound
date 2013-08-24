class CreateQrcodes < ActiveRecord::Migration
  def change
    add_column :users, :qr_code_uid, :string
  end
end
