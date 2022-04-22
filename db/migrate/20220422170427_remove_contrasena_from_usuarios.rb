class RemoveContrasenaFromUsuarios < ActiveRecord::Migration[6.0]
  def change
    remove_column :usuarios, :contrasena, :string
  end
end
