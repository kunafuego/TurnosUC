# frozen_string_literal: true

class TurnosController < ApplicationController
  include TurnosHelper

  def new
    @turno = Turno.new
  end

  def create
    @turnos_params = params.require(:turno).permit(:tipo, :limite_personas, :direccion_llegada,
                                                   :dia_de_la_semana, :direccion_salida, :hora, :minutos)
    @turnos_params[:hora_salida] = "#{@turnos_params[:hora]}:#{@turnos_params[:minutos]}"
    @turnos_params.delete(:hora)
    @turnos_params.delete(:minutos)
    if usuario_signed_in?
      @turnos_params[:id_creador] = current_usuario.id
      @turno = Turno.create(@turnos_params)
      if @turno.save
        redirect_to turnos_index_path, notice: 'Turno Creado'
      else
        redirect_to turnos_index_path, notice: 'Turno no Creado'
      end
    else
      redirect_to usuario_session_path, notice: 'Error al crear el turno, el usuario no estaba logeado'
    end
  end

  def index
    params[:razon] = 'Buscador de Turnos' unless params.key?(:razon)
    @mis_turnos = if current_usuario
                    Turno.where(id_creador: current_usuario.id).all
                  else
                    []
                  end
    if current_usuario
      @pertenezco = PerteneceA.where(id_usuario: current_usuario.id).all
      @ids_turnos_que_pertenezco = []
      @pertenezco.each do |turno|
        @ids_turnos_que_pertenezco << turno.id_turno
      end
      @turnos_que_estoy = Turno.where(id: @ids_turnos_que_pertenezco).all
    else
      @turnos_que_estoy = []
    end
    @turnos_buscador = Turno.all - @mis_turnos - @turnos_que_estoy
  end

  def show
    @turno = Turno.find(params[:id])
    @creador = Usuario.find(@turno.id_creador)
    @resenas = @turno.resenas.all.order(created_at: :desc)
    # Con esta info debo buscar en las otras tablas los elementos que quiero mandar al show
    @mostrar_solicitar_unirse = mostrar_solicitar_unirse(@turno.id, current_usuario.id)
    @mostrar_salirse_del_turno = mostrar_salirse_del_turno(@turno.id, current_usuario.id)

    @id_pertenece_a = PerteneceA.find_by(id_turno: @turno.id, id_usuario: current_usuario.id) if @mostrar_salirse_del_turno
  end

  def edit
    @turno = Turno.find(params[:id])
  end

  def update
    @turno = Turno.find(params[:id])
    @turnos_new_params = params.require(:turno).permit(:tipo, :limite_personas, :direccion_llegada,
                                                       :dia_de_la_semana, :direccion_salida, :hora, :minutos)
    @turnos_new_params[:hora_salida] = "#{@turnos_new_params[:hora]}:#{@turnos_new_params[:minutos]}"
    @turnos_new_params.delete(:hora)
    @turnos_new_params.delete(:minutos)
    if @turno.update(@turnos_new_params)
      redirect_to turnos_index_path, notice: 'Turno editado'
    else
      redirect_to turnos_index_path, notice: 'Turno no editado'
    end
  end

  def delete
    @turno = Turno.find(params[:id])
    @turno.destroy

    redirect_to turnos_index_path, notice: 'Turno eliminado'
  end

  def redirect
    client = Signet::OAuth2::Client.new(client_options)
    redirect_to client.authorization_uri.to_s
  end


  def client_options
    {
      client_id: Rails.application.secrets.google_client_id,
      client_secret: Rails.application.secrets.google_client_secret,
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
      redirect_uri: 'http://localhost:3000/turnos/agregar'
    }
  end

  def agregar
    client = Signet::OAuth2::Client.new(client_options)
    client.code = params[:code]
    response = client.fetch_access_token!
    session[:authorization] = response
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client
  end

  def new_event
    @evento_params = params.require(:evento).permit(:fecha_termino, :turno_id)
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    turno = Turno.find(@evento_params[:turno_id])
    fecha_salida = Date.today.next_occurring(translate(turno.dia_de_la_semana)).to_s + "T" + turno.hora_salida
    hora = turno.hora_salida[0,2].to_i + 1
    fecha_llegada = fecha_salida.gsub(turno.hora_salida, hora.to_s+turno.hora_salida[2,5])

    if @evento_params[:fecha_termino] == "1 mes"
      hasta = Date.today + 30.days
    elsif @evento_params[:fecha_termino] == "2 meses"
      hasta = Date.today + 60.days
    elsif @evento_params[:fecha_termino] == "6 meses"
      hasta = Date.today + 180.days
    elsif @evento_params[:fecha_termino] == "1 año"
      hasta = Date.today + 360.days
    end
    event = Google::Apis::CalendarV3::Event.new(
      summary: 'Turno',
      start: {
        date_time: fecha_salida + ':00.000-04:00',
        time_zone:  'America/Santiago'
      },
      end: {
        date_time: fecha_llegada + ':00.000-04:00',
        time_zone: 'America/Santiago'
      },
      recurrence: ['RRULE:FREQ=WEEKLY;UNTIL=' + hasta.to_s.tr('-','') + 'T000000Z']
    )
    response = service.insert_event('primary', event)
    Evento.create()
    redirect_to turnos_index_path, notice: 'Calendario Agregado'
  end

  def translate (dia)
    if dia.downcase == "lunes"
      return :monday
    elsif dia.downcase == "martes"
      return :tuesday
    elsif dia.downcase == "miercoles"
      return :wednesday
    elsif dia.downcase == "jueves"
      return :thursday
    elsif dia.downcase == "viernes"
      return :friday
    elsif dia.downcase == "sabado"
      return :saturday
    elsif dia.downcase == "domingo"
      return :sunday
    end
  end
end
