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

ActiveRecord::Schema.define(:version => 20120116015210) do

  create_table "domains", :force => true do |t|
    t.string    "domain"
    t.integer   "user_id"
    t.date      "registration_date"
    t.date      "expiration_date"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.boolean   "alert_month"
    t.boolean   "alert_week"
    t.boolean   "alert_day"
    t.text      "page_html"
    t.string    "page_title"
    t.string    "page_h1"
    t.string    "page_h2"
    t.text      "page_meta"
    t.integer   "page_title_diff"
    t.integer   "page_html_diff"
    t.string    "ip_address"
  end

  create_table "identities", :force => true do |t|
    t.string    "name"
    t.string    "email"
    t.string    "password_digest"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string    "provider"
    t.string    "uid"
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.boolean   "alert_month"
    t.boolean   "alert_week"
    t.boolean   "alert_day"
    t.string    "email"
  end

end
