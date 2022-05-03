require 'faker'

FactoryBot.define do
  factory :usuario do
    email { Faker::Internet.email }
    password { "holahola" }
    nombre { "Bob Bobson" }
    direccion { 'Av. Lo Contador' }
    telefono { '99999999' } 
    imagen { Faker::Internet.url}
  end
end