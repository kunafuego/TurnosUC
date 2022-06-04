require 'rails_helper'

describe Usuarios::RegistrationsController do
  describe 'Post#create' do
    before :each do
      request.env['devise.mapping'] = Devise.mappings[:usuario]
    end

    it 'creates a new user' do
      expect do
        post :create, params: { usuario: attributes_for(:usuario) }
      end.to change(Usuario, :count).by(1)
    end
  end

  describe 'PATCH #UPDATE' do
    before :each do
      request.env['devise.mapping'] = Devise.mappings[:usuario]
      @usuario = create(:usuario)
      @old_email = @usuario.email
      sign_in @usuario
    end
    context 'valid attributes' do
      it 'updates user attributes' do
        patch :update, params: { id: @usuario.id, usuario: { email: 'sisi@gmail.com', current_password: 'holahola' } }
        expect(@usuario.reload.email).not_to eq(@old_email)
      end
    end
  end
end
