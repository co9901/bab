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

ActiveRecord::Schema.define(:version => 20120216143658) do

  create_table "contacts", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.string   "mail"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "evaluations", :force => true do |t|
    t.integer  "restaurant_id"
    t.integer  "user_id"
    t.integer  "speed"
    t.integer  "taste"
    t.integer  "amount"
    t.integer  "service"
    t.string   "review"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "goodbads", :force => true do |t|
    t.integer  "menu_id"
    t.integer  "user_id"
    t.boolean  "good"
    t.boolean  "bad"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "menus", :force => true do |t|
    t.string   "menuname"
    t.string   "price"
    t.integer  "liking"
    t.integer  "disliking"
    t.integer  "restaurant_id"
    t.boolean  "setmenu"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "recommendations", :force => true do |t|
    t.string   "date"
    t.integer  "res_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "restaurants", :force => true do |t|
    t.string   "resname"
    t.string   "phone"
    t.integer  "tastepoint"
    t.integer  "speedpoint"
    t.integer  "servicepoint"
    t.integer  "amountpoint"
    t.integer  "count"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.text     "resinfo"
    t.string   "restype"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "mailname"
    t.string   "username"
    t.string   "password"
    t.string   "authorize_token"
    t.boolean  "authorized"
    t.boolean  "mailcheck"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
