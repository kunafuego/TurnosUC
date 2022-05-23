# frozen_string_literal: true

require 'rails_helper'
require 'faker'

RSpec.describe Resena, type: :request do
  before(:each) do
    @usuario = create(:usuario)
    @segundo_usuario = create(:usuario)
    sign_in @usuario

    @turno = create(:turno, usuario: @usuario)

<<<<<<< HEAD
    @resena = Resena.create!({ usuario_id: @usuario.id, turno_id: @turno.id,
                               calificacion: 10.0, contenido: 'Buen turno' })
=======
    @pertenece_a = PerteneceA.create!({id_usuario: @segundo_usuario.id, id_turno: @turno.id})

    @resena = Resena.create!({usuario_id: @segundo_usuario.id, turno_id: @turno.id,
                                calificacion: 10.0, contenido: 'Buen turno'})

    # Params
    @params_resena= {
      usuario_id: @segundo_usuario.id, 
      turno_id: @turno.id,
      calificacion: 10.0, 
      contenido: 'Buen turno'
    }
>>>>>>> e0e96bb0b553c8ad94a96f4234f0d8420f7087bc
  end

  describe 'get new' do
    it 'deberia retornar una respuesta existosa' do
      get '/resenas/new'
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'create' do
    it 'deberia aumentar en 1 la cantidad de resenas' do
      expect do
<<<<<<< HEAD
        post '/resenas', params: { resena: { usuario_id: 1, turno_id: 1,
                                             calificacion: 10.0, contenido: 'Buen turno' } }
=======
        post '/resenas', params: {resena: @params_resena}
>>>>>>> e0e96bb0b553c8ad94a96f4234f0d8420f7087bc
      end.to change(Resena, :count).by(1)
    end
    it 'no deberia aumentar la cantidad de resenas' do
      expect do
        post '/resenas',
             params: { resena: { usuario_id: 1, turno_id: 2,
                                 contenido: 'Buen turno' } }
      end.to change(Resena, :count).by(0)
    end
  end

  describe 'delete' do
    it 'deberia disminuir en 1 la cantidad de resenas' do
      expect do
        delete resenas_delete_path(resena_id: @resena.id)
      end.to change(Resena, :count).by(-1)
    end
  end
end
