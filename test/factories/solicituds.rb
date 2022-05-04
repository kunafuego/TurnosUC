# frozen_string_literal: true

FactoryBot.define do
  factory :solicitud do
    id_usuario { 1 }
    id_turno { 1 }
    descripcion { 'MyText' }
  end
end
