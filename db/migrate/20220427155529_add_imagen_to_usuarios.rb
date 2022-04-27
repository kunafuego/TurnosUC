class AddImagenToUsuarios < ActiveRecord::Migration[6.0]
  def change
    add_column :usuarios, :imagen, :string
  end
end
