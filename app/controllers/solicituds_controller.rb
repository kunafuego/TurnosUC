# frozen_string_literal: true

class SolicitudsController < ApplicationController
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
      @solicitud_params[:estado] = "Pendiente"
      @solicitud = Solicitud.create(@solicitud_params)

      if @solicitud.save
        # Eliminamos la solicitud hecha con anterioridad
        if @solicitud_anterior_id != []
          Solicitud.find(@solicitud_anterior_id[0]).destroy
        end
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
    if params[:tipo] == 'mis solicitudes'
      @mis_solicitudes = Solicitud.where(id_usuario: current_usuario.id).all
      @tipo = 'mis solicitudes'
    else
      @mis_turnos = Turno.where(id_creador: current_usuario.id).all
      @ids_mis_turnos = []
      @mis_turnos.each do |turno|
        @ids_mis_turnos << turno.id
      end
      @solicitudes_hechas_a_mis_turnos = Solicitud.where(id_turno: @ids_mis_turnos).all
      @tipo = 'solicitudes hechas a mis turnos'
    end
  end

  def update
    puts "Se entró al update"
    @solicitud = Solicitud.find(params[:id])
    @solicitud_new_params = params.require(:solicitud).permit(:descripcion, :id_turno, :estado, :id_usuario)
    if @solicitud.update(@solicitud_new_params)
      puts "Se guardó la nueva solicitud con su estado"
      if @solicitud_new_params[:estado] == "Aceptada"
        puts "Había sido aceptada"
        redirect_to pertenece_as_new_path(:id_usuario => @solicitud_new_params[:id_usuario], :id_turno => @solicitud_new_params[:id_turno])
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
  end

  def delete
    @solicitud = Solicitud.find(params[:id])
    @solicitud.destroy
    redirect_to solicituds_index_path(tipo: 'mis solicitudes'), notice: 'Solicitud eliminada'
  end
end
