# frozen_string_literal: true

class Solicitud < ApplicationRecord
  belongs_to :usuario
  validates :id_usuario, presence: true, numericality: { only_integer: true }
  validates :id_turno, presence: true, numericality: { only_integer: true }
end
