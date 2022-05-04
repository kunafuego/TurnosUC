require 'rails_helper'
require 'faker'

RSpec.describe Solicitud, type: :request do
  describe 'get index' do
    it 'deberia retornar una respuesta existosa' do
      get '/solicituds'
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'get new' do
    it 'deberia retornar una respuesta existosa' do
      get '/solicituds/new'
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'create' do
    it 'deberia aumentar en 1 la cantidad de solicitudes' do
      expect do
        post '/solicituds', params: {solicitud: { id_usuario: 1, id_turno: 2, descripcion: 'hola hola' } }
      end.to change(Solicitud, :count).by(1)
    end
    it 'no deberia aumentar la cantidad de solicitudes' do
      expect do
        post '/solicituds', params: { solicitud: { id_usuario: 1, id_turno: 2, descripcion: 'mas de 100 caracteres                                                                                ' } }
      end.to change(Solicitud, :count).by(0)
    end
  end

  describe 'edit' do
    it 'deberia retornar una respuesta existosa' do
      get "/solicituds/#{solicitud.id}/edit"
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'update' do
    it 'deberia actualizar la solicitud' do
      expect do
        patch solicituds_update_path(id: @solicitud.id), params: { solicitud: { descripcion: 'hola hola' } }
        solicitud.reload
      end.to change(solicitud, :descripcion)
    end
  end
  describe 'update' do
    it 'no deberia actualizar la solicitud' do
      expect do
        patch solicituds_update_path(id: @solicitud.id), params: { solicitud: { descripcion: 'mas de 100 caracteres                                                                                ' } }
        solicitud.reload
      end.to_not change(solicitud, :descripcion)
    end
  end

  describe 'delete' do
    it 'deberia disminuir en 1 la cantidad de solicitudes' do
      expect do
        delete "/solicituds/#{solicitud.id}"
      end.to change(Solicitud, :count).by(-1)
    end
  end

end
