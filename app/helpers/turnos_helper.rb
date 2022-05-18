# frozen_string_literal: true

module TurnosHelper
  def mostrar_solicitar_unirse(idt, idu)
    if PerteneceA.exists?(id_usuario: idu, id_turno: idt)
      false
    else
      !Solicitud.exists?(id_usuario: idu, id_turno: idt, estado: 'pendiente')
    end
  end

  def mostrar_salirse_del_turno(idt, idu)
    PerteneceA.exists?(id_usuario: idu, id_turno: idt)
  end
end
