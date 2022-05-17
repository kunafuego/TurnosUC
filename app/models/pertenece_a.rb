# frozen_string_literal: true

class PerteneceA < ApplicationRecord
  validates :id_usuario, presence: true, numericality: { only_integer: true }
  validates :id_turno, presence: true, numericality: { only_integer: true }

  belongs_to :usuario, foreign_key: "id_usuario"
  belongs_to :turno, foreign_key: "id_turno"

end
