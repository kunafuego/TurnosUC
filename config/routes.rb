# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :usuarios, controllers: {
    sessions: 'usuarios/sessions',
    registrations: 'usuarios/registrations'
    },
    path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout', sing_up: 'register'
    }

end
