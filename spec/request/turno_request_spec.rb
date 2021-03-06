# frozen_string_literal: true

require 'rails_helper'
require 'faker'

# Se agrupan todos los tests relacionados al controlador de Profiles,
# con esta línea se le dice a Rails que será testeado
RSpec.describe Turno, type: :request do
  before(:each) do
    # Aqui se utiliza la factory de usuarios, para crear uno
    @usuario = create(:usuario)
    # Usamos el metodo definido en support
    sign_in @usuario

    @params_turno = {
      tipo: 'ida',
      limite_personas: 3,
      calle_llegada: 'Benito Rebolledo',
      numero_llegada: 10,
      comuna_llegada: 'San Joaquin',
      calle_salida: 'Benito Rebolledo',
      numero_salida: 10,
      comuna_salida: 'Las Condes',
      dia_de_la_semana: 'lunes',
      hora: '10',
      minutos: '30',
      id_creador: @usuario.id
    }

    @params_invalid_turno = {
      tipo: 'ida',
      limite_personas: 'a',
      calle_llegada: 'Benito Rebolledo',
      numero_llegada: '10',
      comuna_llegada: 'San Joaquin',
      calle_salida: 'Benito Rebolledo',
      numero_salida: '10',
      comuna_salida: 'Las Condes',
      dia_de_la_semana: 'lunes martes',
      hora: '10',
      minutos: '30',
      id_creador: @usuario.id
    }

    # Aqui se utiliza la factory de turnos, para crear uno
    @turno = create(:turno, usuario: @usuario)
  end

  # Aqui comienzan los test
  describe 'index' do
    it 'debiera retornar una respuesta existosa' do
      get turnos_index_path(razon: 'Buscador de Turnos')
      expect(response).to have_http_status(:ok)
    end
    it 'debiera retornar una respuesta existosa' do
      get turnos_index_path(razon: 'Mis Turnos')
      expect(response).to have_http_status(:ok)
    end
    it 'debiera retornar una respuesta existosa' do
      get turnos_index_path(razon: 'Turnos de los que Participo')
      expect(response).to have_http_status(:ok)
    end
    it 'deberia retornar una respuesta exitosa' do
      get turnos_index_path(busqueda_por_direccion: 'Santa Blanca')
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'get new' do
    it 'debiera retornar una respuesta existosa' do
      get '/turnos/new'
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'get_show' do
    it 'should return a successful request' do
      get turnos_show_path(id: @turno.id, id_creador: @usuario.id)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'create' do
    # La idea es que cuando cree el turno, la cuenta aumente en 1
    it 'debiera aumentar la cantidad de Turnos en 1' do
      expect do
        post '/turnos', params: { turno: @params_turno }
      end.to change(Turno, :count).by(1)
    end
    # Se pasan atributos invalidos y se ve que la cuenta de Publicaciones no cambie
    it 'should not increase count of Turnos' do
      expect do
        post '/turnos', params: { turno: @params_invalid_turno }
      end.to change(Turno, :count).by(0)
    end
  end

  describe 'edit' do
    it 'debiera retornar una respuesta existosa' do
      get turnos_edit_path(id: @turno.id)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'update' do
    it 'deberia de cambiar el Turno' do
      expect do
        patch turnos_update_path(id: @turno.id), params: { turno: { hora: '11', minutos: '30' } }
        # Se recarga la instancia de turno nuevamente con los posibles nuevos atributos
        # Luego se revisa si cambió alguno de los atributos del usuario
        @turno.reload
      end.to change(@turno, :hora_salida)
    end
  end

  # En este caso se trata de haer un update pero con atributos que no son válidos por las validaciones hechas.
  describe 'update' do
    it 'no deberia de cambiar el Turno' do
      expect do
        patch turnos_update_path(id: @turno.id), params: { turno: { dia_de_la_semana: 'hola hola', hora: '10', minutos: '30' } }
        # Se recarga la instancia de turno nuevamente con los posibles nuevos atributos
        # Luego se revisa si cambió alguno de los atributos del turno
        @turno.reload
      end.to_not change(@turno, :direccion_salida)
    end
  end

  describe 'delete' do
    it 'deberia de disminuir la cantidad de Turnos en 1' do
      expect do
        delete turnos_delete_path(id: @turno.id)
      end.to change(Turno, :count).by(-1)
    end
  end

  # describe 'new_event' do

  #   before :each do
  #     controller.stub(:oauth2).and_return(true)
  #   end

  #   it 'deberia crear un evento' do
  #     expect do
  #       post '/eventos', params: {evento: {turno_id: @turno.id, fecha_termino: '6 meses'}}
  #     end.to change(Evento, :count).by(1)
  #   end
  # end
end
