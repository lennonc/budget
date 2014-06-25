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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140625030448) do

  create_table "categories", force: true do |t|
    t.string   "category_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "proposed_budgets", force: true do |t|
    t.datetime "proposed_date"
    t.integer  "user_id"
    t.decimal  "amount",        precision: 10, scale: 2
    t.decimal  "decimal",       precision: 10, scale: 2
    t.integer  "category_id"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "budget_type"
  end

  create_table "transactions", force: true do |t|
    t.integer  "user_id"
    t.date     "date_of_transaction"
    t.string   "description"
    t.string   "transaction_type"
    t.decimal  "amount",              precision: 10, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_salt"
    t.string   "password_digest"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
