# frozen_string_literal: true

module SolicitudsHelper
  def turno_lleno(idt)
    # Que las relaciones pertence a no superen el limite del turno
    PerteneceA.where(id_turno: idt).ids.count >= Turno.find(idt).limite_personas
  end
end
