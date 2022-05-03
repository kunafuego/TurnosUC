class AddEstadoToSolicituds < ActiveRecord::Migration[6.0]
  def change
    add_column :solicituds, :estado, :string
  end
end
