class PerteneceA < ApplicationRecord
  validates :id_usuario, presence: true, numericality: { only_integer: true }
  validates :id_turno, presence: true, numericality: { only_integer: true }
end
