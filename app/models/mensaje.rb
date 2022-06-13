# frozen_string_literal: true

class Mensaje < ApplicationRecord
  validates :cuerpo, presence: true
  validates :turno_id, presence: true, numericality: { only_integer: true }

  belongs_to :usuario
  belongs_to :turno
  after_create_commit { broadcast_append_to turno }
end
