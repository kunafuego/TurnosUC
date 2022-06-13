# frozen_string_literal: true

FactoryBot.define do
  factory :evento do
    fecha_termino { '2022-06-01' }
    turno_id { 1 }
  end
end
