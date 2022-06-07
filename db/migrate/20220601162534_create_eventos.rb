class CreateEventos < ActiveRecord::Migration[6.0]
  def change
    create_table :eventos do |t|
      t.date :fecha_termino
      t.integer :turno_id

      t.timestamps
    end
  end
end
