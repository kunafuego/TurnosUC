require 'rails_helper'

RSpec.describe Turno, type: :model do
  # Similar al before each, pero ahora usando los métodos let y create de FactoryBot
  # Además, usamos la factory de perfiles que definimos
  let(:turno) { create(:turno) }

  it 'is valid with valid attributes' do
    expect(turno).to be_valid
  end

  it 'no es valido sin direccion de llegada' do
    turno.direccion_llegada = nil
    expect(turno).not_to be_valid
  end

  it 'no es valido sin direccion de salida' do
    turno.direccion_salida = nil
    expect(turno).not_to be_valid
  end

  it 'no es valido sin dia de semana' do
    turno.dia_de_la_semana = nil
    expect(turno).not_to be_valid
  end

  it 'no es valido con una oracion para el dia la semana' do
    turno.dia_de_la_semana = 'martes jueves'
    expect(turno).not_to be_valid
  end

  it 'no es valido sin tipo de viaje' do
    turno.tipo = nil
    expect(turno).not_to be_valid
  end
end