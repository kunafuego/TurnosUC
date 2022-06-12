class RolifyCreateAdmins < ActiveRecord::Migration[6.0]
  def change
    create_table(:admins) do |t|
      t.string :name
      t.references :resource, :polymorphic => true

      t.timestamps
    end

    create_table(:usuarios_admins, :id => false) do |t|
      t.references :usuario
      t.references :admin
    end
    
    add_index(:admins, [ :name, :resource_type, :resource_id ])
    add_index(:usuarios_admins, [ :usuario_id, :admin_id ])
  end
end
