require 'rails_helper'
require 'faker'

# Se agrupan todos los tests relacionados al controlador de Profiles,
# con esta línea se le dice a Rails que será testeado
RSpec.describe Turno, type: :request do

  # No se utliza la factory de turnos
  before(:each) do
    @params_turno = {
      tipo: 'ida',
      limite_personas: 3,
      direccion_llegada: 'San Joaquin',
      dia_de_la_semana: 'lunes',
      direccion_salida: 'Av. Lo Contador',
      hora: '10',
      minutos: '30'
    }

    @params_invalid_turno = {
      tipo: 'ida',
      limite_personas: 'a',
      direccion_llegada: 'San Joaquin',
      dia_de_la_semana: 'lunes martes',
      direccion_salida: 'Av. Lo Contador',
      hora: '10',
      minutos: '30'
    }

    # Aqui se utiliza la factory de usuarios, para crear uno
    @usuario = create(:usuario)
    # Usamos el metodo definido en support
    sign_in @usuario

    # Aqui se utiliza la factory de turnos, para crear uno
    @turno = create(:turno)

  end

  # Aqui comienzan los test
  describe 'index' do
      it 'debiera retornar una respuesta existosa' do
        get '/turnos/index'
        expect(response).to have_http_status(:ok)
      end
  end

  describe 'get new' do
    it 'debiera retornar una respuesta existosa' do
      
      get '/turnos/new'
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
      get "/turnos/edit/#{@turno.id}"
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'update' do
    it 'deberia de cambiar el Turno' do
      expect do
        patch "/turno/#{@turno.id}", params: { turno: { hora: '11' } }
        # Se recarga la instancia de turno nuevamente con los posibles nuevos atributos
        # Luego se revisa si cambió alguno de los atributos del usuario
        @turno.reload
      end.to change(@turno, :hora_salida)
    end
  end

  describe 'delete' do
    it 'deberia de disminuir la cantidad de Turnos en 1' do
      expect do
        delete "/turnos/delete/#{@turno.id}"
      end.to change(Turno, :count).by(-1)
    end
  end
  
end

=begin

# En este caso se trata de haer un update pero con atributos que no son válidos por las validaciones hechas.
describe 'update' do
  it 'no deberia de cambiar el Turno' do
    expect do
      patch "/turno/#{@turno.id}", params: { turno: { direccion_llegada: 'Av. Matta', tipo: 'ida', direccion_salida: 111 } }
      # Se recarga la instancia de turno nuevamente con los posibles nuevos atributos
      # Luego se revisa si cambió alguno de los atributos del turno
      turno.reload
    end.to_not change(Turno, :attributes)
  end
end


=end