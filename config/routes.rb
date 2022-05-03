# frozen_string_literal: true

Rails.application.routes.draw do
  ########################## SOLICITUD ############################
  get 'solicitudes/new'
  get 'solicitudes/index'
  get 'solicitudes/show'
  get 'solicitudes/edit'
  post 'solicitudes', to: 'solicitudes#create'
  delete 'solicitudes/delete', to: 'solicitudes#delete', as: 'solicitudes_delete'
  patch 'solicitudes/update', to: 'solicitudes#update', as: 'solicitudes_update'

  ########################## TURNOS ############################
  root to: 'turnos#index'
  get 'turnos/new'
  post 'turnos', to: 'turnos#create'
  get 'turnos/index'
  get 'turnos/show'
  get 'turnos/edit'
  patch 'turnos/update', to: 'turnos#update', as: 'turnos_update'
  delete 'turnos/delete', to: 'turnos#delete', as: 'turnos_delete'



  devise_for :usuarios, controllers: {
    sessions: 'usuarios/sessions',
    registrations: 'usuarios/registrations'
    },
    path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout', sing_up: 'register'
    }

end
