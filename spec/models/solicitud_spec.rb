# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Solicitud, type: :model do

  before(:each) do
    # Aqui se utiliza la factory de usuarios, para crear uno
    @usuario = create(:usuario)
    @segundo_usuario = create(:usuario)

    # Creamos el turno
    @turno = create(:turno, usuario: @usuario)

    # Aqui creamos la solicitud
    @solicitud = Solicitud.create!({ id_usuario: @segundo_usuario.id, id_turno: @turno.id, descripcion: 'si si' })

  end

  it 'es valida con atributos validos' do
    expect(@solicitud).to be_valid
  end

  it 'no es valida sin usuario' do
    @solicitud.id_usuario = nil
    expect(@solicitud).not_to be_valid
  end

  it 'no es valida sin turno' do
    @solicitud.id_turno = nil
    expect(@solicitud).not_to be_valid
  end
end
