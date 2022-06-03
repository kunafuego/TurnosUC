# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Usuario, type: :model do
  # Similar al before each, pero ahora usando los métodos let y create de FactoryBot
  # Además, usamos la factory de perfiles que definimos
  let(:usuario) { create(:usuario) }

  it 'is valid with valid attributes' do
    expect(usuario).to be_valid
  end

  it 'no es valido sin nombre' do
    usuario.nombre = nil
    expect(usuario).not_to be_valid
  end

  it 'no es valido sin numero de telefono' do
    usuario.telefono = nil
    expect(usuario).not_to be_valid
  end

  it 'no es valido sin calle' do
    usuario.calle = nil
    expect(usuario).not_to be_valid
  end

  it 'no es valido sin comuna' do
    usuario.comuna = nil
    expect(usuario).not_to be_valid
  end

  it 'no es valido sin numero' do
    usuario.numero = nil
    expect(usuario).not_to be_valid
  end

  it 'no es valido sin imagen' do
    usuario.imagen = nil
    expect(usuario).not_to be_valid
  end

  it 'no es valido sin url valido de imagen' do
    usuario.imagen = 'https//aaaaa'
    expect(usuario).not_to be_valid
  end
end
