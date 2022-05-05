class CreatePerteneceAs < ActiveRecord::Migration[6.0]
  def change
    create_table :pertenece_as do |t|
      t.integer :id_usuario
      t.integer :id_turno

      t.timestamps
    end
  end
end
