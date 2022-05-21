# frozen_string_literal: true

Rails.application.routes.draw do
  get 'resenas/index'
  get 'resenas/show'
  get 'resenas/new'
  get 'resenas/edit'
  get 'resenas/create'
  get 'resenas/update'
  get 'resenas/destroy'
  ########################## PERTENECE A ############################

  post 'pertenece_as', to: 'pertenece_as#create'
  get 'pertenece_as/new', to: 'pertenece_as#new', as: 'pertenece_as_new'
  delete 'pertenece_as/delete', to: 'pertenece_as#delete', as: 'pertenece_as_delete'

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
  # get 'turnos/:id', to: 'turnos#show', as: 'turno'
  get 'turnos/edit'
  patch 'turnos/update', to: 'turnos#update', as: 'turnos_update'
  delete 'turnos/delete', to: 'turnos#delete', as: 'turnos_delete'

  ########################## RESEÑAS ############################
  get 'resenas/new'
  post 'resenas', to: 'resenas#create'


  devise_for :usuarios, controllers: {
    sessions: 'usuarios/sessions',
    registrations: 'usuarios/registrations'
  },
                        path: '', path_names: {
                          sign_in: 'login',
                          sign_out: 'logout', sing_up: 'register'
                        }
end
