class ResenasController < ApplicationController
  def new
    @id_turno = params[:turno_id]
    @id_creador = params[:creador_id]
    @resena = Resena.new
  end

  def create
    @resena_params = params.require(:resena).permit(:calificacion, :contenido, :turno_id, :usuario_id)
    @resena_params[:calificacion] = @resena_params[:calificacion].to_f
    @resena_params[:turno_id] = @resena_params[:turno_id].to_i
    @resena_params[:usuario_id] = current_usuario.id
    
    @resena = Resena.new(@resena_params)

    if @resena.save
      redirect_to turnos_show_path(:id => @resena.turno.id, :id_creador => @resena.turno.id_creador)
    else
      redirect_to resenas_new_path(:turno_id => @resena_params[:turno_id]), notice: 'Error al crear la reseña'
    end
  end

  def delete
    @resena = Resena.find(params[:resena_id])
    @resena.destroy
    redirect_to turnos_show_path(:id => @resena.turno.id, :id_creador => @resena.turno.id_creador)
  end

  # def index
  # end

  # def edit
  # end

  # def update
  # end

end
