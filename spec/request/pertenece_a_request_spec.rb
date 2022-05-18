require 'rails_helper'
require 'faker'

RSpec.describe PerteneceA, type: :request do

  before(:each) do
    # Aqui se utiliza la factory de usuarios, para crear uno
    @usuario = create(:usuario)
    @segundo_usuario = create(:usuario)
    sign_in @usuario

    # Aqui se utiliza la factory de turnos, para crear uno
    @turno = create(:turno, usuario: @usuario)
    sign_out @usuario

    # Params
    @params_pertenece_a= {
      id_usuario: @segundo_usuario.id,
      id_turno: @turno.id
    }

    @invalid_params_pertenece_a = {
      id_usuario: 'si',
      id_turno: @turno.id
    }

    # Creamos la relacion pertece A
    @pertenece_a = PerteneceA.create!( {id_usuario: @segundo_usuario.id, id_turno: @turno.id } )
    
  end

  # Empiezan los test
  # describe 'get new' do
  #   it 'deberia retornar una respuesta existosa' do
  #     get '/pertenece_as/new'
  #     expect(response).to have_http_status(:ok)
  #   end
  # end

  describe 'create' do
    it 'deberia aumentar en 1 la cantidad de pertenece' do
      expect do
        post '/pertenece_as', params: { pertenece_a: @params_pertenece_a }
      end.to change(PerteneceA, :count).by(1)
    end
    it 'no deberia aumentar la cantidad de pertence' do
      expect do
        post '/pertenece_as',
             params: { pertenece_a: @invalid_params_pertenece_a }
      end.to change(PerteneceA, :count).by(0)
    end
  end

  describe 'delete' do
    it 'deberia disminuir en 1 la cantidad de pertenece a' do
      expect do
        delete pertenece_as_delete_path(id_pertenece_a: @pertenece_a.id)
      end.to change(PerteneceA, :count).by(-1)
    end
  end
end
