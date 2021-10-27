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

ActiveRecord::Schema.define(version: 2021_10_27_090120) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actions", force: :cascade do |t|
    t.string "name"
    t.string "labels"
    t.string "descriptions"
    t.string "inverse"
    t.string "main"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "agent_links", force: :cascade do |t|
    t.bigint "entity_id", null: false
    t.bigint "action_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["action_id"], name: "index_agent_links_on_action_id"
    t.index ["entity_id"], name: "index_agent_links_on_entity_id"
  end

  create_table "datatypes", force: :cascade do |t|
    t.string "name"
    t.string "labels"
    t.string "descriptions"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "datatypes_fields", force: :cascade do |t|
    t.bigint "datatype_id", null: false
    t.bigint "field_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["datatype_id"], name: "index_datatypes_fields_on_datatype_id"
    t.index ["field_id"], name: "index_datatypes_fields_on_field_id"
  end

  create_table "entities", force: :cascade do |t|
    t.string "name"
    t.string "labels"
    t.string "descriptions"
    t.bigint "parent_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["parent_id"], name: "index_entities_on_parent_id"
  end

  create_table "entities_fields", force: :cascade do |t|
    t.bigint "entity_id", null: false
    t.bigint "field_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["entity_id"], name: "index_entities_fields_on_entity_id"
    t.index ["field_id"], name: "index_entities_fields_on_field_id"
  end

  create_table "enumeration_members", force: :cascade do |t|
    t.string "name"
    t.string "labels"
    t.string "descriptions"
    t.bigint "enum_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["enum_id"], name: "index_enumeration_members_on_enum_id"
  end

  create_table "enums", force: :cascade do |t|
    t.string "name"
    t.string "labels"
    t.string "descriptions"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "enums_fields", force: :cascade do |t|
    t.bigint "enum_id", null: false
    t.bigint "field_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["enum_id"], name: "index_enums_fields_on_enum_id"
    t.index ["field_id"], name: "index_enums_fields_on_field_id"
  end

  create_table "fields", force: :cascade do |t|
    t.string "name"
    t.string "labels"
    t.string "descriptions"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "target_links", force: :cascade do |t|
    t.bigint "entity_id", null: false
    t.bigint "action_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["action_id"], name: "index_target_links_on_action_id"
    t.index ["entity_id"], name: "index_target_links_on_entity_id"
  end

  add_foreign_key "agent_links", "actions"
  add_foreign_key "agent_links", "entities"
  add_foreign_key "datatypes_fields", "datatypes"
  add_foreign_key "datatypes_fields", "fields"
  add_foreign_key "entities", "entities", column: "parent_id"
  add_foreign_key "entities_fields", "entities"
  add_foreign_key "entities_fields", "fields"
  add_foreign_key "enumeration_members", "enums"
  add_foreign_key "enums_fields", "enums"
  add_foreign_key "enums_fields", "fields"
  add_foreign_key "target_links", "actions"
  add_foreign_key "target_links", "entities"
end
