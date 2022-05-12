# frozen_string_literal: true

class TurnosController < ApplicationController
  def new
    @turno = Turno.new
  end

  def create
    @turnos_params = params.require(:turno).permit(:tipo, :limite_personas, :direccion_llegada,
                                                   :dia_de_la_semana, :direccion_salida, :hora, :minutos)
    @turnos_params[:hora_salida] = "#{@turnos_params[:hora]}:#{@turnos_params[:minutos]}"
    @turnos_params.delete(:hora)
    @turnos_params.delete(:minutos)
    if usuario_signed_in?
      @turnos_params[:id_creador] = current_usuario.id
      @turno = Turno.create(@turnos_params)
      if @turno.save
        redirect_to turnos_index_path, notice: 'Turno Creado'
      else
        redirect_to turnos_index_path, notice: 'Turno no Creado'
      end
    else
      redirect_to usuario_session_path, notice: 'Error al crear el turno, el usuario no estaba logeado'
    end
  end

  def index
    @mis_turnos = if current_usuario
                    Turno.where(id_creador: current_usuario.id).all
                  else
                    []
                  end
    if current_usuario
      @pertenezco = PerteneceA.where(id_usuario: current_usuario.id).all
      @ids_turnos_que_pertenezco = []
      @pertenezco.each do |turno|
        @ids_turnos_que_pertenezco << turno.id_turno
      end
      @turnos_que_estoy = Turno.where(id: @ids_turnos_que_pertenezco).all
    else
      @turnos_que_estoy = []
    end
    @turnos_buscador = Turno.all - @mis_turnos - @turnos_que_estoy
  end

  def show
    @turno = Turno.find(params[:id])
    @creador = Usuario.find(params[:id_creador])
    # Con esta info debo buscar en las otras tablas los elementos que quiero mandar al show
    @mostrar_solicitar_unirse = mostrar_solicitar_unirse(@turno.id, current_usuario.id)
  end

  def mostrar_solicitar_unirse(idt, idu)
    if PerteneceA.exists?(:id_usuario => idu, :id_turno => idt)
      return false
    elsif Solicitud.exists?(:id_usuario => idu, :id_turno => idt, :estado => "pendiente")
      return false
    else
      return true
    end
  end

  def edit
    @turno = Turno.find(params[:id])
  end

  def update
    @turno = Turno.find(params[:id])
    @turnos_new_params = params.require(:turno).permit(:tipo, :limite_personas, :direccion_llegada,
                                                       :dia_de_la_semana, :direccion_salida, :hora, :minutos)
    @turnos_new_params[:hora_salida] = "#{@turnos_new_params[:hora]}:#{@turnos_new_params[:minutos]}"
    @turnos_new_params.delete(:hora)
    @turnos_new_params.delete(:minutos)
    if @turno.update(@turnos_new_params)
      redirect_to turnos_index_path, notice: 'Turno editado'
    else
      redirect_to turnos_index_path, notice: 'Turno no editado'
    end
  end

  def delete
    @turno = Turno.find(params[:id])
    @turno.destroy

    redirect_to turnos_index_path, notice: 'Turno eliminado'
  end
end
