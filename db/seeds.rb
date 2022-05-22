# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
usuarios = Usuario.create([{direccion:"Santa Blanca", 
                            nombre: "Juan Perez",
                            telefono: "78728458",
                            imagen:  "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAHcAAABeCAMAAAAuRHtGAAABAlBMVEX////6vAXqQjU0qFNChvX6uAAmpUjpMR81gPT34KPxu7eSyqGfv/X///36ugAspkzoNCPqPjDpOjclp1TW7Nr57+30ysb42dX55eX89/foTT7pTkPpdGrwrajpLBfoOSrramHlU0T00dHphX7oQjrnW1HrlI78+en56Lb414X4y1b3xDL2vhv7yEn61Xf68tT50Wn678f54Jrvn5nyv8PuuqnvrofupmLwmjvwkiH5kA3vaFbzmIzi04rMym20wFKdszuYlmiVY6qcfbydlM6Zq+He6/N8xZdLsm4ump+h07DS4vuz28Bpu4BNqJ8qevV2up5SkfV6pfqCrfS4zvPk8+tBZLx3AAADi0lEQVRoge3YWVfaQBgG4ElCQhAGMi1uVYnWJVAQsPtea1ugokUC/P+/0klYhPAlGWfi5Mb3HD2HGx/f2TIBoac8Bc7m1tb2zq589kXWssje/sGOXHejotIQYtmHG1LdrDoLyR69TMOlcuUYp+GqqrUna5pXXZWo26m4dIXJgYOuSk42U3FV+zAdV60cpOOqFQkjDbn2cTqujMKgaz3+DIMuOU3HVe1HPy5h10romYhDnzMhfc+SN1c/wy7ZT8BFyKnWXtUbjcZ5M9cK/BchbgILy8nVdb1Io9AfXVeaLQb3SMzEyKkV9aKyHF0/X5LD+gpePKpKQJ3KbSfOFVJxG1B9uXGBcJQrsK7oGNd1UKUpFnNRfe2vAm2dOlx2BU7+3IhkPbga4fKek/RwaEeyXlphLv82wuh16Nwu0sAhrv0G8e4jR4mtq+i1sOc+/+OoHV+XzrED33P4d1GLhVX0Jnyv46/bZHKLCgZc64x7dnGDhaWFq2/XXHo2cx/OF0x1aeH2mkv47zgY1Vjd+jsrOMoiL9/nbCzNezuwprYEWMSweWf5QFZ2EBFpizHjMNN8fLZc9lDsRcFhdz8tXGKdiN5eH+wSYlunB7sR912WvYURvcnFpujf9T5b2WwlS7583Y7+w2x72snF59v3H5eXlz+vrq5+/f5TiE8nie+Yyt3ecy/GXzOTMTMmQzLCML7WjJLmx3fZMugLujclQ5tHnotv71Xq/mN3hca5rC2zWumO2TUFuqLyfGLnfe+GrO5QpO2qSt28y1jYHPEP80QLxsgXGN3BmN/tBetSt886wR1u9toA+iKXbZhd7rrro+y74wGT2+eum1+v67mYaUUnW9d3+wyFTf7D6gao67kIj2KXllngv9veri3mmRs/0gKLCh7maV/UyUQ3Hnb465ahYZ72pVMcBYs9eYHNu3BRVGNzyH9i0OSh6V24aDfsnB64IipC3WgX47EJyGZmzD+1fsDlfO96y2sUkOnHgpDJ4tJWuFNwp1c8/3fGFe3qJWacpzZ1+oWR6w7dUaHvfxQOdDoH3ZmN57/E1ZBjEnARTqbnPGtXnDA34WCIleDCC0uCCx7QElzcS8cFnwwyXKiwjHGGZlhGX+jMkuLi9RcGOX3pFJdScSlspOIGXvfluXQbl0qpuGjSvX/pl+l6317Nv0gyrmW6tPNNt6eVDEObyHVp8GRSLstnn/Lw/AefV2i4QOdrkgAAAABJRU5ErkJggg==",
                            email: "pa@uc.cl",
                            password: "123456",
                            password_confirmation: "123456"},
                            {direccion:"Bernardo Larrain", 
                            nombre: "Pablo Salazar",
                            telefono: "77857528",
                            imagen:  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSIngtT_c3UtdRFwBXXeRyxYdPWc53-n3_XWgXsCbbcZA&s",
                            email: "ab@uc.cl",
                            password: "123456",
                            password_confirmation: "123456"},
                            {direccion:"Los nogaes", 
                            nombre: "Pedro juanes",
                            telefono: "77857528",
                            imagen:  "data:image/png;base64,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",
                            email: "ad@uc.cl",
                            password: "123456",
                            password_confirmation: "123456"}
                            ])
turnos = Turno.create([{tipo: "ida",
                        limite_personas: 5,
                        direccion_llegada: "PUC",
                        dia_de_la_semana: "martes",
                        direccion_salida: "los trape",
                        hora_salida: "10:20",
                        id_creador: 9},
                        {tipo: "vuelta",
                        limite_personas: 3,
                        direccion_llegada: "Lalos",
                        dia_de_la_semana: "miercoles",
                        direccion_salida: "bernardo larrain",
                        hora_salida: "13:20",
                        id_creador: 10}
                        ])
