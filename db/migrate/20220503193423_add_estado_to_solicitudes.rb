class AddEstadoToSolicitudes < ActiveRecord::Migration[6.0]
  def change
    add_column :solicitudes, :estado, :string
  end
end
