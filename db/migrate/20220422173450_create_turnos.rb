class CreateTurnos < ActiveRecord::Migration[6.0]
  def change
    create_table :turnos do |t|
      t.string :tipo
      t.integer :limite_personas
      t.text :direccion_llegada
      t.string :dia_de_la_semana
      t.text :direccion_salida
      t.string :hora_salida
      t.integer :id_creador

      t.timestamps
    end
  end
end
