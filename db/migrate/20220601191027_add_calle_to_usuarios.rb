class AddCalleToUsuarios < ActiveRecord::Migration[6.0]
  def change
    add_column :usuarios, :calle, :string
  end
end
