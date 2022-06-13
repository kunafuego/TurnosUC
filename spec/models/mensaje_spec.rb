# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mensaje, type: :model do
  before(:each) do
    # Aqui se utiliza la factory de usuarios, para crear uno
    @usuario = create(:usuario)

    # Aqui se utiliza la factory de turnos, para crear uno
    @turno = create(:turno, usuario: @usuario)

    # Creamos la relacion pertece A
    @mensaje = Mensaje.create!({ turno_id: @turno.id, usuario_id: @usuario.id, cuerpo: "hola hola" })
  end

  it 'es valida con atributos validos' do
    expect(@mensaje).to be_valid
  end

  it 'no es valida sin usuario' do
    @mensaje.cuerpo = nil
    expect(@mensaje).not_to be_valid
  end

  it 'no es valida sin turno' do
    @mensaje.turno_id = nil
    expect(@mensaje).not_to be_valid
  end
end
