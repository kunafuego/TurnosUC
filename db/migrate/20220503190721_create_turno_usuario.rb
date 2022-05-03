class CreateTurnoUsuario < ActiveRecord::Migration[6.0]
  def change
    create_table :turno_usuarios do |t|
      t.integer :id_turno
      t.integer :id_usuario

      t.timestamps
    end
  end
end
