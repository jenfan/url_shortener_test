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

ActiveRecord::Schema.define(version: 2021_08_10_013849) do

  create_table "request_ip_stats", id: false, force: :cascade do |t|
    t.string "ip"
    t.integer "visit_count", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ip"], name: "index_request_ip_stats_on_ip"
  end

  create_table "short_urls", id: false, force: :cascade do |t|
    t.string "slug"
    t.string "origin_url"
    t.integer "show_count", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["origin_url"], name: "index_short_urls_on_origin_url", unique: true
    t.index ["slug"], name: "index_short_urls_on_slug", unique: true
  end

end
