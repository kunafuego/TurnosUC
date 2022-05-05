class DropTurnoUsuario < ActiveRecord::Migration[6.0]
  def change
    drop_table :turno_usuarios
  end
end
