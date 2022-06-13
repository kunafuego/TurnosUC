# frozen_string_literal: true

require 'rails_helper'
require 'faker'

RSpec.describe Mensaje, type: :request do
  before(:each) do
    # Aqui se utiliza la factory de usuarios, para crear uno
    @usuario = create(:usuario)

    # Creamos el turno
    sign_in @usuario
    @turno = create(:turno, usuario: @usuario)

    # Params
    @params = {
      cuerpo: 'hola hola',
      turno_id: @turno.id,
      usuario_id: @usuario.id
    }

    @params_invalid = {
      cuerpo: nil,
      turno_id: @turno.id,
      usuario_id: @usuario.id
    }

    @mensaje = Mensaje.create!({ turno_id: @turno.id, cuerpo: 'hola hola', usuario_id: @usuario.id })
  end

  # Empiezan los test
  # describe 'create' do
  #   it 'deberia aumentar en 1 la cantidad de mensajes' do
  #     expect do
  #       post '/mensajes', params: { mensaje: @params }
  #     end.to change(Mensaje, :count).by(1)
  #   end
  #   it 'no deberia aumentar la cantidad de mensajes' do
  #     expect do
  #       post '/mensajes', params: { mensaje: @params_invalid }
  #     end.to change(Mensaje, :count).by(0)
  #   end
  # end

  describe 'delete' do
    it 'deberia disminuir en 1 la cantidad de mensajes' do
      expect do
        delete mensajes_delete_path(id: @mensaje.id)
      end.to change(Mensaje, :count).by(-1)
    end
  end
end
