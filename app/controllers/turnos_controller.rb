# frozen_string_literal: true

class TurnosController < ApplicationController
  include TurnosHelper

  def new
    @turno = Turno.new
  end

  def create
    @params = params.require(:turno).permit(:tipo, :limite_personas, :dia_de_la_semana,
                                                   :calle_salida, :numero_salida, :comuna_salida,
                                                        :calle_llegada, :numero_llegada, :comuna_llegada, 
                                                            :hora, :minutos)
    @params[:hora_salida] = "#{@params[:hora]}:#{@params[:minutos]}"
    @params.delete(:hora)
    @params.delete(:minutos)

    @params[:direccion_salida] = "#{@params[:calle_salida]} #{@params[:numero_salida]}, #{@params[:comuna_salida]}"
    @params.delete(:calle_salida)
    @params.delete(:numero_salida)
    @params.delete(:comuna_salida)

    @params[:direccion_llegada] = "#{@params[:calle_llegada]} #{@params[:numero_llegada]}, #{@params[:comuna_llegada]}"
    @params.delete(:calle_llegada)
    @params.delete(:numero_llegada)
    @params.delete(:comuna_llegada)
    if usuario_signed_in?
      @params[:id_creador] = current_usuario.id
      @turno = Turno.create(@params)
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
    params[:razon] = 'Buscador de Turnos' unless params.key?(:razon)
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
    @turnos_buscador = Turno.all
  end

  def show
    @turno = Turno.find(params[:id])
    @creador = Usuario.find(@turno.id_creador)
    @resenas = @turno.resenas.all.order(created_at: :desc)
    # Con esta info debo buscar en las otras tablas los elementos que quiero mandar al show
    @mostrar_solicitar_unirse = mostrar_solicitar_unirse(@turno.id, current_usuario.id)
    @mostrar_salirse_del_turno = mostrar_salirse_del_turno(@turno.id, current_usuario.id)

    @id_pertenece_a = PerteneceA.find_by(id_turno: @turno.id, id_usuario: current_usuario.id) if @mostrar_salirse_del_turno
  end

  def edit
    @turno = Turno.find(params[:id])
  end

  def update
    @new_params = params.require(:turno).permit(:tipo, :limite_personas, :dia_de_la_semana,
                                              :calle_salida, :numero_salida, :comuna_salida,
                                                  :calle_llegada, :numero_llegada, :comuna_llegada, 
                                                      :hora, :minutos)
    @new_params[:hora_salida] = "#{@new_params[:hora]}:#{@new_params[:minutos]}"
    @new_params.delete(:hora)
    @new_params.delete(:minutos)

    @new_params[:direccion_salida] = "#{@new_params[:calle_salida]},#{@new_params[:numero_salida]},#{@new_params[:comuna_salida]}"
    @new_params.delete(:calle_salida)
    @new_params.delete(:numero_salida)
    @new_params.delete(:comuna_salida)

    @new_params[:direccion_llegada] = "#{@new_params[:calle_llegada]},#{@new_params[:numero_llegada]},#{@new_params[:comuna_llegada]}"
    @new_params.delete(:calle_llegada)
    @new_params.delete(:numero_llegada)
    @new_params.delete(:comuna_llegada)
    if @turno.update(@new_params)
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
