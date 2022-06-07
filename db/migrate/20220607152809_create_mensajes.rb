class CreateMensajes < ActiveRecord::Migration[6.0]
  def change
    create_table :mensajes do |t|
      t.references :usuario, null: false, foreign_key: true
      t.references :turno, null: false, foreign_key: true
      t.text :cuerpo

      t.timestamps
    end
  end
end
