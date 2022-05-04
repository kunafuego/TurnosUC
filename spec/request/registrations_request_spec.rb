require 'rails_helper'
require 'faker'

# Se agrupan todos los tests relacionados al controlador de Profiles,
# con esta línea se le dice a Rails que será testeado
RSpec.describe Usuarios::RegistrationsController, type: :request do

  # No se utliza la factory de turnos
  before(:each) do
    @params_usuario = {
      nombre: 'Bob bovson',
      telefono: '99999999',
      email: 'bob@gmail.com',
      direccion: 'Av. Jose',
      contrasena: 'holahola',
      imagen: 'https://1.bp.blogspot.com/-UaI6EkGWgls/X-e62mKsCMI/AAAAAAABhjQ/5P-OMHjV6gkXtVPw9COSVtOPygUn7sK6ACLcBGAsYHQ/s16000/Colo%2BColo.png'
    }

    @params_invalid_usuario = {
        nombre: 'Bob bovson',
        telefono: '99999999',
        email: 'bob@gmail.com',
        direccion: 'Av. Jose',
        contrasena: 'holahola',
        imagen: 'https://aaaaaa'
      }
    end
end