# frozen_string_literal: true

Rails.application.routes.draw do
  post 'pertenece_as', to: 'pertenece_as#create'
  get 'pertenece_as/new', to: 'pertenece_as#new', as: 'pertenece_as_new'
  ########################## SOLICITUD ############################
  get 'solicituds/new'
  get 'solicituds/index'
  get 'solicituds/show'
  get 'solicituds/edit'
  post 'solicituds', to: 'solicituds#create'
  delete 'solicituds/delete', to: 'solicituds#delete', as: 'solicituds_delete'
  patch 'solicituds/update', to: 'solicituds#update', as: 'solicituds_update'

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
