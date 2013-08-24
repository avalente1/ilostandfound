class CreateDb < ActiveRecord::Migration
  def change
    create_table "messages", force: true do |t|
    t.integer  "find_id"
    t.integer  "owner_id"
    t.string   "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "text"
    end
    create_table "users", force: true do |t|
      t.string   "first_name"
      t.string   "last_name"
      t.boolean  "cell_show"
      t.string   "cell_number"
      t.boolean  "email_show"
      t.boolean  "home_phone_show"
      t.string   "home_phone"
      t.string   "password_digest"
      t.string   "address1"
      t.string   "address2"
      t.string   "city"
      t.string   "state"
      t.string   "postal"
      t.text     "qrcode", :limit => nil
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "email"
      t.text     "delivery_options"
      t.text     "qr_code_uid"
      t.float    "latitude"
      t.float    "longitude"
      t.string   "ip_address"
    end
  end
end




