# frozen_string_literal: true

class UsuariosController < ApplicationController
  def delete
    @usuario = Usuario.find(params[:id_usuario])
    @usuario.destroy

    @turno = Turno.find(params[:turno_id])

    # puts "********************"
    # puts @turno.id
    # puts params[:usuario_id]

    # @usuario_pertenece_a = PerteneceA.where(id_turno: @turno.id, id_usuario: params[:usuario_id])

    # puts "222222222222222222222"
    # @usuario_pertenece_a.destroy

    redirect_to turnos_show_path(id: @turno.id, id_creador: @turno.id_creador)
  end
end
