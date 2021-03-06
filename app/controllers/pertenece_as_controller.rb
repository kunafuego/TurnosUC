# frozen_string_literal: true

class PerteneceAsController < ApplicationController
  def create
    @tupla_params = params.require(:pertenece_a).permit(:id_usuario, :id_turno)
    @tupla = PerteneceA.create(@tupla_params)
    if @tupla.save
      redirect_to solicituds_index_path(tipo: 'solicitudes hechas a mis turnos'), notice: 'Solicitud aceptada'
    else
      redirect_to solicituds_index_path(tipo: 'solicitudes hechas a mis turnos'), notice: 'Solicitud no aceptada'
    end
  end

  def new
    @tupla = PerteneceA.new
    @params = params
  end

  def delete
    @pertenece_a = PerteneceA.find(params[:id_pertenece_a])
    @pertenece_a.destroy
    redirect_to turnos_index_path(razon: 'Buscador de Turnos'), notice: 'Has salido existosamente del Turno'
  end
end
