README
===

# Flujo de la Aplicacion

Haciendo uso de devise creo el CRUD de "Usuarios". Al que solo se le modifico el hecho de que  
tenga asocidados otros atributos como: numero de telefono, direccion y url de imagen.

Luego, se creo el CRUD de turnos, donde todos los usuarios (registrados y no registrados) pueden visualizar los turnos ofrecidos. 
Pero, sololos usuarios registrados pueden ver los turnos que ellos han creado, entrar al "show" del turno para ver los detalles 
especificos, editarlos y eliminarlos. Mientras que los usuarios no registrados, al tratar de ver los detalles del turno, van a ser 
redirigidos al registro.

Asi tambien, se creo el CRUD de solicitudes. En el que dentro del "show" de un turno, un usuario registrado (que no es el creador), 
puede enviar una solicitud de union al creador de este. Y, dentro del index de turnos, el usuario creador tiene la opcion de dirigirse
a otra pagina que le permite vizualizar todas las solicitudes que le han llegado, con el fin de aceptarlas o rechazarlas.

Si el creador acepta la solicitud, el usuario que la envio va a ser incorporado en el turno, es decir, el usuario queda
ligado al turno a traves de una relacion (tabla) "Pertence_A".

---

# Heroku y Diagrama E/R

* El link para ver el proyecto en Heroku, es el siguiente:

https://uc-turnos.herokuapp.com/  

* Por otro lado, el diagrama E/R se encuentra en la carpeta `docs`.

---

# Cambios al RuboCop

Se le añadió los siguientes Cop's al archivo rubocop.yml:  

* Rubocop exigía que todos los archivos comenzaran con un comentario(que la idea era que fuera documentación),
y con ese Cop ya no se debe cumplir esa condición.  

* Este cop lo que hace es determinar que el máximo largo de un método es de 100 líneas. El predeterminado
eran 10 y se hacía muy corto para algunos métodos del controlador.  

* Se cambió el máximo largo de las lineas a 160, porque habían algunas llaves creadas automáticamente
por Rails que se pasaban del límite.

* Se cambió el máximo de ABC size para los métodos a 22 puntos, en vez de los 15 que venían predeterminados.

* Se cambió la cantidad mínima de caracteres para los bloques, ya que un bloque que se creó
automaticamente con rails venía con un bloque de un caracter.

* Se dejó 100 como la máxima cantidad de líneas por bloque. Este error pasaba mucho en los test de los controladores, ya que cada controlador se tomaba como un bloque.

---

Gracias!  