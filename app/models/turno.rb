class Turno < ApplicationRecord
    belongs_to :usuario
    has_many :usuarios
end
