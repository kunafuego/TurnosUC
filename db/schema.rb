# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_06_12_183551) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_admins_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_admins_on_resource_type_and_resource_id"
  end

  create_table "eventos", force: :cascade do |t|
    t.date "fecha_termino"
    t.integer "turno_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "mensajes", force: :cascade do |t|
    t.bigint "usuario_id", null: false
    t.bigint "turno_id", null: false
    t.text "cuerpo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["turno_id"], name: "index_mensajes_on_turno_id"
    t.index ["usuario_id"], name: "index_mensajes_on_usuario_id"
  end

  create_table "pertenece_as", force: :cascade do |t|
    t.integer "id_usuario"
    t.integer "id_turno"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "resenas", force: :cascade do |t|
    t.bigint "usuario_id"
    t.bigint "turno_id"
    t.float "calificacion"
    t.text "contenido"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["turno_id"], name: "index_resenas_on_turno_id"
    t.index ["usuario_id"], name: "index_resenas_on_usuario_id"
  end

  create_table "solicituds", force: :cascade do |t|
    t.integer "id_usuario"
    t.integer "id_turno"
    t.text "descripcion"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "estado"
  end

  create_table "turnos", force: :cascade do |t|
    t.string "tipo"
    t.integer "limite_personas"
    t.text "direccion_llegada"
    t.string "dia_de_la_semana"
    t.text "direccion_salida"
    t.string "hora_salida"
    t.integer "id_creador"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "nombre"
    t.string "telefono"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "imagen"
    t.string "calle"
    t.string "comuna"
    t.integer "numero"
    t.index ["email"], name: "index_usuarios_on_email", unique: true
    t.index ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true
  end

  create_table "usuarios_admins", id: false, force: :cascade do |t|
    t.bigint "usuario_id"
    t.bigint "admin_id"
    t.index ["admin_id"], name: "index_usuarios_admins_on_admin_id"
    t.index ["usuario_id", "admin_id"], name: "index_usuarios_admins_on_usuario_id_and_admin_id"
    t.index ["usuario_id"], name: "index_usuarios_admins_on_usuario_id"
  end

  add_foreign_key "mensajes", "turnos"
  add_foreign_key "mensajes", "usuarios"
end
