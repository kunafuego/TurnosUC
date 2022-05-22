# frozen_string_literal: true

FactoryBot.define do
  factory :resena do
    # usuario_id { 1 }
    turno_id { 1 }
    association :usuario
    association :turno
    calificacion { 1.5 }
    contenido { 'MyText' }
  end
end
