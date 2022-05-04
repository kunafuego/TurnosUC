# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :turno do
    tipo { %w[ida vuelta].shuffle!.pop }
    limite_personas { Faker::Number.digit }
    direccion_salida { Faker::Lorem.sentence }
    direccion_llegada { Faker::Lorem.sentence }
    dia_de_la_semana { %w[lunes martes miercoles jueves viernes sabado domingo].shuffle!.pop }
    hora_salida { '00:20' }
  end
end
