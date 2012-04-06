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

ActiveRecord::Schema.define(:version => 20120406073604) do

  create_table "alarms", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "active",     :default => true
    t.string   "title"
    t.string   "keyword"
    t.string   "where"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_alarms", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "alarm_id"
  end

  create_table "categories_events", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "event_id"
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.text     "body"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "banned"
  end

  add_index "comments", ["event_id"], :name => "index_comments_on_event_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "communications", :force => true do |t|
    t.integer  "user_id"
    t.integer  "receiver_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.string   "title"
    t.datetime "startDate"
    t.datetime "finishDate"
    t.string   "place"
    t.string   "town"
    t.string   "province"
    t.decimal  "price"
    t.text     "description"
    t.string   "email"
    t.string   "website"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
    t.integer  "user_id"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
    t.string   "address"
    t.text     "des_es"
    t.text     "des_eu"
    t.text     "des_en"
    t.text     "des_fr"
    t.integer  "views",            :default => 0
    t.string   "title_es"
    t.string   "title_eu"
    t.string   "title_fr"
    t.string   "title_en"
    t.boolean  "approved",         :default => false
    t.boolean  "reminded",         :default => false
  end

  create_table "events_users", :id => false, :force => true do |t|
    t.integer "event_id"
    t.integer "user_id"
  end

  create_table "followings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "translations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.text     "des_es"
    t.text     "des_eu"
    t.text     "des_fr"
    t.text     "des_en"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title_es"
    t.string   "title_eu"
    t.string   "title_fr"
    t.string   "title_en"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "town"
    t.string   "province"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
    t.string   "crypted_password"
    t.string   "persistence_token"
    t.boolean  "admin",             :default => false
    t.string   "locale"
    t.string   "perishable_token",  :default => "",    :null => false
    t.integer  "attempts",          :default => 0
  end

  add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token"

end
