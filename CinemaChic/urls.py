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
from chic import views as chic_views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', cinema_views.index),
    path('ocupaciones_usuarios/',cinema_views.mostrar_ocupaciones),
    path('puntuaciones_usuario/',cinema_views.mostrar_puntuaciones_usuario),
    #pasamos el parametro <int:pag> para la paginacion
    path('mejores_peliculas/<int:pag>',cinema_views.mostrar_mejores_peliculas),
    path('busqueda_peliculas/',cinema_views.mostrar_peliculas_year),
    path('pelicula/list',cinema_views.pelicula_list),
    path('pelicula/<int:pelicula_id>/details', cinema_views.pelicula_details),    
    path('categoria/list',cinema_views.categoria_list),
    path('categoria/<int:categoria_id>/details', cinema_views.categoria_details), 
    path('populate/', cinema_views.populateDatabase),
    path('ingresar/', cinema_views.ingresar),    
    path('cargarsr/',cinema_views.cargarSR),
    path('recomendar/',cinema_views.recomendar2peliculas),
    path('recomendarD/',cinema_views.recomendar2peliculasD),
    path('ropa/create/',chic_views.ropa_create),
    path('taza/create/',chic_views.taza_create),
    path('poster/create/',chic_views.poster_create),
    path('accesorio/create/',chic_views.accesorio_create),
    path('ropa/list/',chic_views.ropa_list, name='ropa_list'),
    path('taza/list/',chic_views.taza_list, name='taza_list'),
    path('poster/list/',chic_views.poster_list, name='poster_list'),
    path('accesorio/list/',chic_views.accesorio_list, name='accesorio_list'),
    path('ropa/<int:item_id>/delete',chic_views.ropa_delete),
    path('taza/<int:item_id>/delete',chic_views.taza_delete),
    path('poster/<int:item_id>/delete',chic_views.poster_delete),
    path('accesorio/<int:item_id>/update',chic_views.accesorio_update),
    path('ropa/<int:item_id>/update',chic_views.ropa_update),
    path('taza/<int:item_id>/update',chic_views.taza_update),
    path('poster/<int:item_id>/update',chic_views.poster_update),
    path('accesorio/<int:item_id>/update',chic_views.accesorio_update),
    path('item/<int:item_id>/details',chic_views.ropa_details),
    path('item/<int:item_id>/details',chic_views.taza_details),
    path('item/<int:item_id>/details',chic_views.poster_details),
    path('item/<int:item_id>/details',chic_views.accesorio_details),
]
