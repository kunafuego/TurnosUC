class AddComunaToUsuarios < ActiveRecord::Migration[6.0]
  def change
    add_column :usuarios, :comuna, :string
  end
end
