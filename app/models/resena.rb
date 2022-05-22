class Resena < ApplicationRecord
  belongs_to :usuario
  belongs_to :turno
  validates :usuario_id, presence: true, numericality: { only_integer: true }
  validates :turno_id, presence: true, numericality: { only_integer: true }
  validates :calificacion, presence: true, numericality: {only_float: true}
end
