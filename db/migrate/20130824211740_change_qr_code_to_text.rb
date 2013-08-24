class ChangeQrCodeToText < ActiveRecord::Migration
  def change
    change_column :users, :qrcode, :text
    change_column :users, :qr_code_uid, :text
  end
end
