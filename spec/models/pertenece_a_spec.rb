require 'rails_helper'

RSpec.describe PerteneceA, type: :model do

  before(:each) do
    # Aqui se utiliza la factory de usuarios, para crear uno
    @usuario = create(:usuario)
    @segundo_usuario = create(:usuario)

    # Aqui se utiliza la factory de turnos, para crear uno
    @turno = create(:turno, usuario: @usuario)

    # Creamos la relacion pertece A
    @pertenece_a = PerteneceA.create!( {id_usuario: @segundo_usuario.id, id_turno: @turno.id } )
    
  end

  it 'es valida con atributos validos' do
    expect(@pertenece_a).to be_valid
  end

  it 'no es valida sin usuario' do
    @pertenece_a.id_usuario = nil
    expect(@pertenece_a).not_to be_valid
  end

  it 'no es valida sin turno' do
    @pertenece_a.id_turno = nil
    expect(@pertenece_a).not_to be_valid
  end
end