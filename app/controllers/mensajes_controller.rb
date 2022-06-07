class MensajesController < ApplicationController
    def create
        @mensaje = current_usuario.mensajes.create(cuerpo: msg_params[:cuerpo], turno_id: params[:turno_id])
      end
        
      def msg_params
        params.require(:mensaje).permit(:cuerpo, :turno_id)
      end
    
    def delete
        @mensaje = Mensaje.find(params[:id])
        turno_id = @mensaje.turno.id
        @mensaje.destroy
        redirect_to turnos_show_path(:id => turno_id), notice: 'Mensaje eliminado'
    end
end
