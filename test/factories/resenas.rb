FactoryBot.define do
  factory :resena do
    id_usuario { 1 }
    id_turno { 1 }
    calificacion { 1.5 }
    contenido { "MyText" }
  end
end
