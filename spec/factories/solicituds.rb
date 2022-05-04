# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :solicitud do
    id_usuario { rand(1..100) }
    id_turno { rand(1..100) }
  end
end