# frozen_string_literal: true

class Solicitud < ApplicationRecord
  validates :id_usuario, presence: true, numericality: { only_integer: true }
  validates :id_turno, presence: true, numericality: { only_integer: true }
  validates :descripcion, length: { maximum: 100 }

  belongs_to :usuario, foreign_key: "id_usuario", inverse_of: :solicituds
  belongs_to :turno, foreign_key: "id_turno", inverse_of: :solicituds
end
