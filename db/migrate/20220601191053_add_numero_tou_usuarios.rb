class AddNumeroTouUsuarios < ActiveRecord::Migration[6.0]
  def change
    add_column :usuarios, :numero, :integer
  end
end
