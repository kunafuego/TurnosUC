# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :usuario do
    email { Faker::Internet.email }
    password { 'holahola' }
    password_confirmation { 'holahola' }
    nombre { 'Bob Bobson' }
    calle { 'Av. Lo Contador' }
    numero { 10 }
    comuna { 'San Joaquin' }
    telefono { '99999999' }
    imagen { Faker::Internet.url }
  end
end
