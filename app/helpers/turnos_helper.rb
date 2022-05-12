# frozen_string_literal: true

module TurnosHelper
  def mostrar_solicitar_unirse(idt, idu)
    if PerteneceA.exists?(:id_usuario => idu, :id_turno => idt)
      return false
    elsif Solicitud.exists?(:id_usuario => idu, :id_turno => idt, :estado => "pendiente")
      return false
    else
      return true
    end
  end

  def mostrar_salirse_del_turno(idt, idu)
    if PerteneceA.exists?(:id_usuario => idu, :id_turno => idt)
      return true
    else
      return false
    end
  end
end
