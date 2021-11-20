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

ActiveRecord::Schema.define(version: 2021_11_10_184350) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_models", force: :cascade do |t|
    t.string "name"
    t.string "inverse"
    t.string "main"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "actions", force: :cascade do |t|
    t.boolean "is_default", default: true
    t.bigint "action_model_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["action_model_id"], name: "index_actions_on_action_model_id"
  end

  create_table "datatypes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "entities", force: :cascade do |t|
    t.string "name"
    t.string "order", default: "[]"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "ancestry"
    t.index ["ancestry"], name: "index_entities_on_ancestry"
  end

  create_table "enumeration_members", force: :cascade do |t|
    t.string "name"
    t.bigint "enum_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["enum_id"], name: "index_enumeration_members_on_enum_id"
  end

  create_table "enums", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "field_models", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "field_options", force: :cascade do |t|
    t.bigint "field_model_id", null: false
    t.string "optionable_type", null: false
    t.bigint "optionable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["field_model_id"], name: "index_field_options_on_field_model_id"
    t.index ["optionable_type", "optionable_id"], name: "index_field_options_on_optionable"
  end

  create_table "fields", force: :cascade do |t|
    t.boolean "is_default", default: true
    t.bigint "field_model_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["field_model_id"], name: "index_fields_on_field_model_id"
  end

  create_table "localizables", force: :cascade do |t|
    t.string "type_of"
    t.string "language"
    t.string "value"
    t.string "localizable_type", null: false
    t.bigint "localizable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["localizable_type", "localizable_id"], name: "index_localizables_on_localizable"
  end

  create_table "section_elements", force: :cascade do |t|
    t.bigint "section_id", null: false
    t.string "sectionable_type", null: false
    t.bigint "sectionable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["section_id"], name: "index_section_elements_on_section_id"
    t.index ["sectionable_type", "sectionable_id"], name: "index_section_elements_on_sectionable"
  end

  create_table "sections", force: :cascade do |t|
    t.string "name"
    t.string "order", default: "[]"
    t.string "element_type", default: "Field"
    t.bigint "entity_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["entity_id"], name: "index_sections_on_entity_id"
  end

  create_table "target_links", force: :cascade do |t|
    t.bigint "entity_id", null: false
    t.bigint "action_model_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["action_model_id"], name: "index_target_links_on_action_model_id"
    t.index ["entity_id"], name: "index_target_links_on_entity_id"
  end

  add_foreign_key "actions", "action_models"
  add_foreign_key "enumeration_members", "enums"
  add_foreign_key "field_options", "field_models"
  add_foreign_key "fields", "field_models"
  add_foreign_key "section_elements", "sections"
  add_foreign_key "sections", "entities"
  add_foreign_key "target_links", "action_models"
  add_foreign_key "target_links", "entities"
end
