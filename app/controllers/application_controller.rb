# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    stored_location_for(resource) || turnos_index_path(razon: 'Buscador de Turnos')
  end
end
