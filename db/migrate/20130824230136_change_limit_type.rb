class ChangeLimitType < ActiveRecord::Migration
  def change
    change_column :users, :qrcode, :text, :limit => nil
    change_column :users, :qr_code_uid, :text, :limit => nil
  end
end
