README
===

# Flujo de la Aplicacion

## E3
A continuación se presentan las credenciales del usuario administrador:
* email: `admin@uc.cl`
* contraseña: `123456`

# Heroku

* El link para ver el proyecto en Heroku, es el siguiente:

https://uc-turnos.herokuapp.com/  


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

PD: Se dejó un seed con algunos usuarios y turnos que tal vez puede facilitar la corrección!