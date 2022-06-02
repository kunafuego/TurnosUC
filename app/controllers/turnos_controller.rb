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

    @params = manejar_parametros(@params)
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
    if params[:busqueda_por_direccion]
      search_term = params[:busqueda_por_direccion].downcase
      @turnos = Turno.all.select do |turno|
        turno.direccion_llegada.downcase.include?(search_term) ||
          turno.direccion_salida.downcase.include?(search_term)
      end
    else
      @turnos = Turno.all
    end

    case params[:razon]
    when 'Mis Turnos'
      @turnos = usuario_signed_in? ? @turnos.where(id_creador: current_usuario.id) : []
    when 'Turnos de los que Participo'
      @pertenezco = usuario_signed_in? ? PerteneceA.where(id_usuario: current_usuario.id) : []
      @ids_turnos_que_pertenezco = []
      @pertenezco.each do |turno|
        @ids_turnos_que_pertenezco << turno.id_turno
      end
      @turnos = @turnos.where(id: @ids_turnos_que_pertenezco)
    end
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
    @turno = Turno.find(params[:id])
    @new_params = params.require(:turno).permit(:tipo, :limite_personas, :dia_de_la_semana,
                                                :calle_salida, :numero_salida, :comuna_salida,
                                                :calle_llegada, :numero_llegada, :comuna_llegada,
                                                :hora, :minutos)

    @new_params = manejar_parametros(@new_params)
    puts 'wena wena'
    puts @turno
    puts 'wena wena'
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
