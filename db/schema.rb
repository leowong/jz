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

ActiveRecord::Schema.define(:version => 20110328221416) do

  create_table "activities", :force => true do |t|
    t.integer   "user_id"
    t.integer   "subject_id"
    t.string    "subject_type"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "topic_id"
    t.string    "topic_type"
    t.string    "action"
  end

  create_table "addresses", :force => true do |t|
    t.integer   "province_id"
    t.integer   "city_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "contact_id"
  end

  create_table "annotations", :force => true do |t|
    t.text      "content"
    t.integer   "annotatable_id"
    t.string    "annotatable_type"
    t.string    "type"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "assets", :force => true do |t|
    t.integer   "attachable_id"
    t.string    "attachable_type"
    t.string    "attachment_file_name"
    t.string    "attachment_content_type"
    t.integer   "attachment_file_size"
    t.timestamp "attachment_updated_at"
    t.string    "type"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "billboards", :force => true do |t|
    t.string    "title"
    t.text      "content"
    t.integer   "user_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "cities", :force => true do |t|
    t.string    "name"
    t.integer   "province_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "contacts", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "type1"
    t.integer   "type2"
    t.integer   "type3"
    t.boolean   "sex"
    t.integer   "age_range"
    t.string    "mobile"
    t.string    "phone"
    t.string    "fax"
    t.string    "email"
    t.string    "company"
    t.string    "position"
    t.integer   "source_id"
    t.integer   "interest"
    t.text      "background_info"
  end

  create_table "line_items", :force => true do |t|
    t.integer   "order_id"
    t.integer   "product_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "quantity",   :default => 1
  end

  create_table "orders", :force => true do |t|
    t.integer   "contact_id"
    t.string    "number"
    t.string    "state"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string    "name"
    t.decimal   "price"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "provinces", :force => true do |t|
    t.string    "name"
    t.string    "abbreviation"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "reports", :force => true do |t|
    t.string    "title"
    t.text      "content"
    t.integer   "user_id"
    t.integer   "apply_to"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string    "session_id", :null => false
    t.text      "data"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "sources", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", :force => true do |t|
    t.integer   "user_id"
    t.integer   "assigned_to"
    t.integer   "completed_by"
    t.string    "name"
    t.integer   "subject_id"
    t.string    "subject_type"
    t.timestamp "due_at"
    t.timestamp "completed_at"
    t.timestamp "deleted_at"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string    "username"
    t.string    "email"
    t.string    "password_hash"
    t.string    "password_salt"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "mobile"
    t.string    "phone"
  end

end
