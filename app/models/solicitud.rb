# frozen_string_literal: true

class Solicitud < ApplicationRecord
  validates :id_usuario, presence: true, numericality: { only_integer: true }
  validates :id_turno, presence: true, numericality: { only_integer: true }
  validates :descripcion, length: { maximum: 100 }
end
