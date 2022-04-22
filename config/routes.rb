# frozen_string_literal: true

Rails.application.routes.draw do
  get 'turnos/new'
  post 'turnos', to: 'turnos#create'
  get 'turnos/index'
  get 'turnos/show'
  get 'turnos/edit'
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
