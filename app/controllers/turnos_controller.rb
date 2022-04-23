class TurnosController < ApplicationController
  def new
    @turno = Turno.new
  end

  def create
    @turnos_params = params.require(:turno).permit(:tipo, :limite_personas, :direccion_llegada, 
      :dia_de_la_semana, :direccion_salida, :hora_salida)
    @turnos_params[:id_creador] = current_usuario.id
    @turno = Turno.create(@turnos_params)
    if @turno.save
      redirect_to turnos_index_path, notice: 'Turno Creado'
    else
      redirect_to turnos_index_path, notice: 'Turno no Creado'
    end
  end

  def index
    @mis_turnos = Turno.where(:id_creador => current_usuario.id).all
    @turnos_buscador = Turno.all - @mis_turnos
  end

  def show
    @turno = Turno.find(params[:id])
    @creador = Usuario.find(params[:id_creador])
    #Con esta info debo buscar en las otras tablas los elementos que quiero mandar al show
  end

  def edit
    @turno = Turno.find(params[:id])
  end

  def update
    @turno = Turno.find(params[:id])
    @turnos_new_params = params.require(:turno).permit(:tipo, :limite_personas, :direccion_llegada, 
      :dia_de_la_semana, :direccion_salida, :hora_salida, :id_creador)
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
