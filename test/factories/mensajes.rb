FactoryBot.define do
  factory :mensaje do
    usuario { nil }
    turno { nil }
    cuerpo { "MyText" }
  end
end
