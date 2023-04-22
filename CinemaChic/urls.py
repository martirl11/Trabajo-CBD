"""CinemaChic URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from main import views
from cinema import views as cinema_views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', cinema_views.index),
    path('ocupaciones_usuarios/',cinema_views.mostrar_ocupaciones),
    path('puntuaciones_usuario/',cinema_views.mostrar_puntuaciones_usuario),
    #pasamos el parametro <int:pag> para la paginacion
    path('mejores_peliculas/<int:pag>',cinema_views.mostrar_mejores_peliculas),
    path('busqueda_peliculas/',cinema_views.mostrar_peliculas_year),
    path('index.html/', cinema_views.index),
    path('populate/', cinema_views.populateDatabase),
    path('ingresar/', cinema_views.ingresar),    
    path('cargarsr/',cinema_views.cargarSR),
    path('recomendar/',cinema_views.recomendar2peliculas),
    path('recomendarD/',cinema_views.recomendar2peliculasD)
]
