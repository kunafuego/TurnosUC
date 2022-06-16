# frozen_string_literal: true

class UsuariosController < ApplicationController
  def delete
    @usuario = Usuario.find(params[:id_usuario])
    @usuario.destroy

    @turno = Turno.find(params[:turno_id])

    redirect_to turnos_show_path(id: @turno.id, id_creador: @turno.id_creador)
  end
end
