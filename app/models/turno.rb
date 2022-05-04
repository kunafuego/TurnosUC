# frozen_string_literal: true

class Turno < ApplicationRecord
  validates :tipo, presence: true
  validates :direccion_salida, presence: true
  validates :direccion_llegada, presence: true
  validates :hora_salida, presence: true
  validates :dia_de_la_semana, presence: true, format: {
    with: /\A[A-Za-z]+\z/,
    message: 'tiene que ser una sola palabra'
  }
  validates :limite_personas, presence: true, numericality: { only_integer: true }
end
