# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121102193902) do

  create_table "knb_auction_auctions", :force => true do |t|
    t.integer  "start_price"
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer  "product_id"
    t.integer  "created_by_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "knb_auction_bids", :force => true do |t|
    t.integer  "owner_id"
    t.datetime "bid_at"
    t.integer  "amount"
    t.integer  "auction_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "knb_auction_products", :force => true do |t|
    t.text     "name"
    t.text     "description"
    t.integer  "price"
    t.integer  "sku",         :limit => 8
    t.integer  "upc",         :limit => 8
    t.boolean  "approved"
    t.integer  "supplier_id"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

end