# frozen_string_literal: true

class SolicitudsController < ApplicationController
  include SolicitudsHelper

  def new
    @solicitud = Solicitud.new
    @id_turno = params[:id_turno]
    # Luego podriamos intentar que esto no lo lleve a un nuevo link, sino que sea más como un pop up en pantalla
  end

  def create
    @solicitud_params = params.require(:solicitud).permit(:descripcion, :id_turno)
    if usuario_signed_in?

      # Si el usuario ya habia hecho una solicitud a ese turno, queremos buscar el id de dicha solicitud
      @id_turno = @solicitud_params[:id_turno]
      @solicitud_anterior_id = Solicitud.where(id_usuario: current_usuario.id, id_turno: @id_turno).ids

      @solicitud_params[:id_usuario] = current_usuario.id
      @solicitud_params[:estado] = 'Pendiente'
      @solicitud = Solicitud.create(@solicitud_params)

      if @solicitud.save
        # Eliminamos la solicitud hecha con anterioridad
        Solicitud.find(@solicitud_anterior_id[0]).destroy if @solicitud_anterior_id != []
        redirect_to solicituds_index_path(tipo: 'mis solicitudes'), notice: 'Solicitud Creada'
      else
        redirect_to solicituds_index_path(tipo: 'mis solicitudes'), notice: 'Solicitud no Creada'
      end
    else
      redirect_to usuario_session_path, notice: 'Error al crear la solicitud, el usuario no estaba loggeado'
    end
  end

  def index
    # Cada vez que se llame a este método habrá un parametro que indicará si se quiere ver
    # las solicitudes hechas por el usuario, o las solicitudes hechas a los turnos del usuario
    case params[:tipo]
    when 'mis solicitudes'
      @solicitudes = usuario_signed_in? ? Solicitud.where(id_usuario: current_usuario.id).all : []
    when 'solicitudes hechas a mis turnos'
      if usuario_signed_in?
        @mis_turnos = usuario_signed_in? ? Turno.where(id_creador: current_usuario.id).all : []
        @ids_mis_turnos = []
        @mis_turnos.each do |turno|
          @ids_mis_turnos << turno.id
        end
        @solicitudes = Solicitud.where(id_turno: @ids_mis_turnos).all
      else
        @solicitudes = []
      end
    else
      @turno = Turno.find(params[:id_turno])
      @solicitudes = Solicitud.where(id_turno: @turno.id).all
    end
  end

  def update
    @solicitud = Solicitud.find(params[:id])
    @solicitud_new_params = params.require(:solicitud).permit(:descripcion, :id_turno, :estado, :id_usuario)
    if @solicitud.update(@solicitud_new_params)
      if @solicitud_new_params[:estado] == 'Aceptada'
        PerteneceA.create!(id_usuario: @solicitud_new_params[:id_usuario], id_turno: @solicitud_new_params[:id_turno])
        redirect_to solicituds_index_path(tipo: 'solicitudes hechas a mis turnos')
      else
        redirect_to solicituds_index_path(tipo: 'solicitudes hechas a mis turnos'), notice: 'Solicitud editada'
      end
    else
      redirect_to solicituds_index_path(tipo: 'solicitudes hechas a mis turnos'), notice: 'Solicitud no editado'
    end
  end

  def edit
    @tipo = params[:tipo_edit]
    @solicitud = Solicitud.find(params[:id])

    # Ahora llamamos la funcion turno lleno, para usarla en las views
    @turno_lleno = turno_lleno(@solicitud.id_turno)
  end

  def delete
    @solicitud = Solicitud.find(params[:id])
    @solicitud.destroy
    redirect_to solicituds_index_path(tipo: 'mis solicitudes'), notice: 'Solicitud eliminada'
  end
end
