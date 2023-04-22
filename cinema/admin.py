from django.contrib import admin
from .models import Pelicula, Categoria, Usuario, Ocupacion, Puntuacion

admin.site.register(Pelicula)
admin.site.register(Categoria)
admin.site.register(Usuario)
admin.site.register(Ocupacion)
admin.site.register(Puntuacion)
