class RemoveCorreoFromUsuarios < ActiveRecord::Migration[6.0]
  def change
    remove_column :usuarios, :correo, :string
  end
end
