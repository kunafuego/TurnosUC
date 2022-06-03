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

  def manejar_parametros(params)
    params[:hora_salida] = "#{params[:hora]}:#{params[:minutos]}"
    params.delete(:hora)
    params.delete(:minutos)

    params[:direccion_salida] = "#{params[:calle_salida]} #{params[:numero_salida]}, #{params[:comuna_salida]}"
    params.delete(:calle_salida)
    params.delete(:numero_salida)
    params.delete(:comuna_salida)

    params[:direccion_llegada] = "#{params[:calle_llegada]} #{params[:numero_llegada]}, #{params[:comuna_llegada]}"
    params.delete(:calle_llegada)
    params.delete(:numero_llegada)
    params.delete(:comuna_llegada)

    params
  end
end
