# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Resena, type: :model do
  let(:resena) { create(:resena) }

  it 'es valida con atributos validos' do
    expect(resena).to be_valid
  end

  it 'no es valida sin usuario' do
    resena.usuario_id = nil
    expect(resena).not_to be_valid
  end

  it 'no es valida sin turno' do
    resena.turno_id = nil
    expect(resena).not_to be_valid
  end

  it 'no es valida sin calificacion' do
    resena.calificacion = nil
    expect(resena).not_to be_valid
  end
end