# frozen_string_literal: true

require 'rails_helper'
require 'faker'

# Se agrupan todos los tests relacionados al controlador de Profiles,
# con esta línea se le dice a Rails que será testeado
RSpec.describe Turno, type: :request do
  # Aqui comienzan los test
  describe 'index' do
    it 'should return a successful request' do
      get '/turnos/index'
      expect(response).to have_http_status(:ok)
    end
  end
end
