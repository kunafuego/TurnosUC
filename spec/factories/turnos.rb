require 'faker'

FactoryBot.define do
  factory :turno do
    tipo { ['ida', 'vuelta'].shuffle!.pop }
    limite_personas { Faker::Number.digit }
    direccion_llegada { Faker::Lorem.sentence }
    dia_de_la_semana { ['lunes', 'martes', 'miercoles', 'jueves', 'viernes', 'sabado', 'domingo'].shuffle!.pop }
    direccion_salida { Faker::Lorem.sentence }
    hora_salida { '00:20' }
  end
end