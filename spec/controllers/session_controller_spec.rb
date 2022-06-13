# frozen_string_literal: true

require 'rails_helper'

describe Usuarios::SessionsController do
  # controller do
  # end

  describe 'After user sigin-in' do
    before(:each) do
      @usuario = create(:usuario)
    end

    it 'change current_user' do
      sign_in @usuario
      expect(subject.current_usuario).to eq(@usuario)
    end

    it 'redirects to the user_root_path' do
      @usuario = create(:usuario)
      expect do
        controller.after_sign_in_path_for(@usuario) == '/turnos/index?razon=Buscador+de+Turnos'
      end
    end
  end
end
