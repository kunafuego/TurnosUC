require 'rails_helper'

RSpec.describe Solicitud, type: :model do
  let(:solicitud) { create(:solicitud) }

  it 'es valida con atributos validos' do
    expect(solicitud).to be_valid
  end

  it 'no es valida sin usuario' do
    solicitud.id_usuario = nil
    expect(solicitud).not_to be_valid
  end

  it 'no es valida sin turno' do
    solicitud.id_turno = nil
    expect(solicitud).not_to be_valid
  end
end
