# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_02_17_032117) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "infecteds", id: false, force: :cascade do |t|
    t.bigint "user_id_reported"
    t.bigint "user_id_notified"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inventories", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_inventories_on_user_id"
  end

  create_table "inventory_items", force: :cascade do |t|
    t.bigint "inventory_id", null: false
    t.bigint "item_id", null: false
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inventory_id"], name: "index_inventory_items_on_inventory_id"
    t.index ["item_id"], name: "index_inventory_items_on_item_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "description", limit: 20, null: false
    t.integer "score", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["description"], name: "index_items_on_description", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.integer "age", null: false
    t.string "gender", limit: 20, null: false
    t.string "latitude", null: false
    t.string "longitude", null: false
    t.boolean "infected", default: false, null: false
    t.integer "contamination_notification", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "infecteds", "users", column: "user_id_notified"
  add_foreign_key "infecteds", "users", column: "user_id_reported"
  add_foreign_key "inventories", "users"
  add_foreign_key "inventory_items", "inventories"
  add_foreign_key "inventory_items", "items"
end
