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

  # Asociaciones
  has_many :pertenece_as
  has_many :usuarios, through: :pertenece_as 
  has_many :solicituds, inverse_of: :turno, dependent: :destroy, foreign_key: "id_turno"

  belongs_to :usuario, foreign_key: "id_creador"
end
