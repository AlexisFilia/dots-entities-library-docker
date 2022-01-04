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

ActiveRecord::Schema.define(version: 2021_12_15_144843) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actions", force: :cascade do |t|
    t.string "name"
    t.string "inverse"
    t.string "main"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "actions_entities", force: :cascade do |t|
    t.bigint "entity_id", null: false
    t.bigint "action_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["action_id"], name: "index_actions_entities_on_action_id"
    t.index ["entity_id"], name: "index_actions_entities_on_entity_id"
  end

  create_table "composants", force: :cascade do |t|
    t.string "code"
    t.bigint "field_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["field_id"], name: "index_composants_on_field_id"
  end

  create_table "entities", force: :cascade do |t|
    t.string "name"
    t.string "child_order", default: "[]"
    t.string "default_fields", default: "[]"
    t.string "default_actions", default: "[]"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "ancestry"
    t.index ["ancestry"], name: "index_entities_on_ancestry"
  end

  create_table "enumeration_members", force: :cascade do |t|
    t.string "name"
    t.bigint "fieldtype_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["fieldtype_id"], name: "index_enumeration_members_on_fieldtype_id"
  end

  create_table "fields", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "fields_fieldtypes", force: :cascade do |t|
    t.bigint "field_id", null: false
    t.bigint "fieldtype_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["field_id"], name: "index_fields_fieldtypes_on_field_id"
    t.index ["fieldtype_id"], name: "index_fields_fieldtypes_on_fieldtype_id"
  end

  create_table "fieldtypes", force: :cascade do |t|
    t.string "name"
    t.string "type_of"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.string "child_order", default: "[]"
    t.string "element_type", default: "field"
    t.bigint "entity_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["entity_id"], name: "index_sections_on_entity_id"
  end

  add_foreign_key "actions_entities", "actions"
  add_foreign_key "actions_entities", "entities"
  add_foreign_key "composants", "fields"
  add_foreign_key "enumeration_members", "fieldtypes"
  add_foreign_key "fields_fieldtypes", "fields"
  add_foreign_key "fields_fieldtypes", "fieldtypes"
  add_foreign_key "section_elements", "sections"
  add_foreign_key "sections", "entities"
end
