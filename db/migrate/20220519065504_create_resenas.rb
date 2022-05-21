class CreateResenas < ActiveRecord::Migration[6.0]
  def change
    create_table :resenas do |t|
      # t.integer :id_usuario
      # t.integer :id_turno
      t.references :usuario
      t.references :turno
      t.float :calificacion
      t.text :contenido

      t.timestamps
    end
  end
end
