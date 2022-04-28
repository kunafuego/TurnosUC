class CreateSolicituds < ActiveRecord::Migration[6.0]
  def change
    create_table :solicituds do |t|
      t.integer :id_usuario
      t.integer :id_turno
      t.text :descripcion

      t.timestamps
    end
  end
end
