# frozen_string_literal: true

FactoryBot.define do
  factory :mensaje do
    usuario { nil }
    turno { nil }
    cuerpo { 'MyText' }
  end
end
