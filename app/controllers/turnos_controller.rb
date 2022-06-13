# frozen_string_literal: true

class TurnosController < ApplicationController
  include TurnosHelper

  def new
    @turno = Turno.new
  end

  def create
    @params = params.require(:turno).permit(:tipo, :limite_personas, :dia_de_la_semana,
                                            :calle_salida, :numero_salida, :comuna_salida,
                                            :calle_llegada, :numero_llegada, :comuna_llegada,
                                            :hora, :minutos)

    @params = manejar_parametros(@params)
    @params[:id_creador] = current_usuario.id
    @turno = Turno.create(@params)
    if @turno.save
      redirect_to turnos_index_path, notice: 'Turno Creado'
    else
      redirect_to turnos_index_path, notice: 'Turno no Creado'
    end
  end

  def index
    if params[:busqueda_por_direccion]
      search_term = params[:busqueda_por_direccion].downcase
      @turnos = Turno.all.select do |turno|
        turno.direccion_llegada.downcase.include?(search_term) ||
          turno.direccion_salida.downcase.include?(search_term)
      end
    else
      @turnos = Turno.all
    end

    case params[:razon]
    when 'Mis Turnos'
      @turnos = usuario_signed_in? ? @turnos.where(id_creador: current_usuario.id) : []
    when 'Turnos de los que Participo'
      @pertenezco = usuario_signed_in? ? PerteneceA.where(id_usuario: current_usuario.id) : []
      @ids_turnos_que_pertenezco = []
      @pertenezco.each do |turno|
        @ids_turnos_que_pertenezco << turno.id_turno
      end
      @turnos = @turnos.where(id: @ids_turnos_que_pertenezco)
    end
  end

  def show
    @turno = Turno.find(params[:id])
    @creador = Usuario.find(@turno.id_creador)
    @resenas = @turno.resenas.all.order(created_at: :desc)
    # Con esta info debo buscar en las otras tablas los elementos que quiero mandar al show
    @mostrar_solicitar_unirse = mostrar_solicitar_unirse(@turno.id, current_usuario.id)
    @mostrar_salirse_del_turno = mostrar_salirse_del_turno(@turno.id, current_usuario.id)
    @mensaje = Mensaje.new
    @mensajes = @turno.mensajes
    @id_pertenece_a = PerteneceA.find_by(id_turno: @turno.id, id_usuario: current_usuario.id) if @mostrar_salirse_del_turno
  end

  def edit
    @turno = Turno.find(params[:id])
  end

  def update
    @turno = Turno.find(params[:id])
    @new_params = params.require(:turno).permit(:tipo, :limite_personas, :dia_de_la_semana,
                                                :calle_salida, :numero_salida, :comuna_salida,
                                                :calle_llegada, :numero_llegada, :comuna_llegada,
                                                :hora, :minutos)

    @new_params = manejar_parametros(@new_params)
    if @turno.update(@new_params)
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
    service
  end

  def new_event
    @evento_params = params.require(:evento).permit(:fecha_termino, :turno_id)
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    turno = Turno.find(@evento_params[:turno_id])
    translate = { 'lunes' => :monday, 'martes' => :tuesday, 'miercoles' => :wednesday, 'jueves' => :thursday, 'viernes' => :friday, 'sabado' => :saturday,
                  'domingo' => :sunday }
    fecha_salida = "#{Date.today.next_occurring(translate[turno.dia_de_la_semana])}T#{turno.hora_salida}"
    hora = turno.hora_salida[0, 2].to_i + 1
    fecha_llegada = fecha_salida.gsub(turno.hora_salida, hora.to_s + turno.hora_salida[2, 5])
    puts fecha_salida
    hasta = { '1 mes' => Date.today + 30.days, '2 meses' => Date.today + 60.days, '6 meses' => Date.today + 180.days, '1 año' => Date.today + 360.days }
    event = Google::Apis::CalendarV3::Event.new(
      summary: 'Turno',
      start: Google::Apis::CalendarV3::EventDateTime.new(
        date_time: "#{fecha_salida}:00.000-04:00",
        time_zone: 'America/Santiago'
      ),
      end: Google::Apis::CalendarV3::EventDateTime.new(
        date_time: "#{fecha_llegada}:00.000-04:00",
        time_zone: 'America/Santiago'
      ),
      recurrence: ["RRULE:FREQ=WEEKLY;UNTIL=#{hasta[@evento_params[:fecha_termino]].to_s.tr('-', '')}T000000Z"]
    )
    service.insert_event('primary', event)
    Evento.create
    redirect_to turnos_index_path, notice: 'Calendario Agregado'
  end
end
