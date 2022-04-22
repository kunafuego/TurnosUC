class TurnosController < ApplicationController
  def new
    @turno = Turno.new
  end

  def create
    @turnos_params = params.require(:turno).permit(:tipo, :limite_personas, :direccion_llegada, 
      :dia_de_la_semana, :direccion_salida, :hora_salida, :id_creador)
    @turno = Turno.create(@turnos_params)
    if @turno.save
      redirect_to turnos_index_path, notice: 'Turno Creado'
    else
      redirect_to turnos_index_path, notice: 'Turno no Creado'
    end
  end
  def index
    @turnos = Turno.all
  end

  def show
  end

  def edit
  end
end
