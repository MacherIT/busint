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

ActiveRecord::Schema.define(version: 20160607200452) do

  create_table "deals", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "fuente"
    t.integer  "probabilidad"
    t.text     "estado"
    t.text     "empresa"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "producto_id"
  end

  add_index "deals", ["producto_id"], name: "index_deals_on_producto_id"
  add_index "deals", ["user_id", "created_at"], name: "index_deals_on_user_id_and_created_at"
  add_index "deals", ["user_id"], name: "index_deals_on_user_id"

  create_table "participacions", force: :cascade do |t|
    t.integer  "deal_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "participacions", ["deal_id", "user_id"], name: "index_participacions_on_deal_id_and_user_id", unique: true
  add_index "participacions", ["deal_id"], name: "index_participacions_on_deal_id"
  add_index "participacions", ["user_id"], name: "index_participacions_on_user_id"

  create_table "productos", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
