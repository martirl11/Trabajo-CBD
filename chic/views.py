from django.shortcuts import render
from .models import *
from cinema.models import *
from .forms import *
from django.contrib import messages
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
import cx_Oracle
dsn_tns = cx_Oracle.makedsn('localhost', '1521', service_name='orcl.home')
connection = cx_Oracle.connect(user="root_cbd_2", password="trabaj0CBD", dsn=dsn_tns)


@login_required
def ropa_create(request):
    form = CreateRopaForm()
    if request.method == 'POST':
        form = CreateRopaForm(request.POST, request.FILES)
        if form.is_valid():
            ropa = form.save(commit=False)
            ropa.save()
            return redirect('ropa_list')
        else:
            messages.error(request, 'Formulario con errores')

    context = {
        "form": form, 
        "title": "Añadir Ropa", 
        "item":"ropa",
        
        
        }

    return render(request, 'create.html', context)

@login_required
def taza_create(request):
    form = CreateTazaForm()
    if request.method == 'POST':
        form = CreateTazaForm(request.POST, request.FILES)
        if form.is_valid():
            taza = form.save(commit=False)
            taza.save()
            return redirect('taza_list')
        else:
            messages.error(request, 'Formulario con errores')

    context = {
        "form": form, 
        "title": "Añadir Taza", 
        "item":"accesorio",
        }

    return render(request, 'create.html', context)

@login_required
def poster_create(request):
    form = CreatePosterForm()
    if request.method == 'POST':
        form = CreatePosterForm(request.POST, request.FILES)
        if form.is_valid():
            poster = form.save(commit=False)
            poster.save()
            return redirect('poster_list')
        else:
            messages.error(request, 'Formulario con errores')

    context = {
        "form": form, 
        "title": "Añadir Poster", 
        "item":"accesorio", 
        }

    return render(request, 'create.html', context)

@login_required
def accesorio_create(request):
    form = CreateAccesorioForm()
    if request.method == 'POST':
        form = CreateAccesorioForm(request.POST, request.FILES)
        if form.is_valid():
            accesorio = form.save(commit=False)
            accesorio.save()
            return redirect('accesorio_list')
        else:
            messages.error(request, 'Formulario con errores')

    context = {
        "form": form, 
        "title": "Añadir Accesorio", 
        "item":"accesorio",
        }

    return render(request, 'create.html', context)

def ropa_list(request):
    objects = Ropa.objects.all()
    title = "Ropa"

    context = {
        'objects': objects,
        'title': title,
        "item":"ropa",
        
    }
    return render(request, 'list.html', context)


def taza_list(request):
    objects = Taza.objects.all()
    title = "Taza"

    context = {
        'objects': objects,
        'title': title,
        "item":"taza",
        
    }
    return render(request, 'list.html', context)

def poster_list(request):
    objects = Taza.objects.all()
    title = "Poster"

    context = {
        'objects': objects,
        'title': title,
        "item":"poster",
        
    }
    return render(request, 'list.html', context)

def accesorio_list(request):
    objects = Taza.objects.all()
    title = "Accesorios"

    context = {
        'objects': objects,
        'title': title,
        "item":"accesorio",
        
    }
    return render(request, 'list.html', context)

@login_required
def ropa_delete(request, item_id):
    ropa = get_object_or_404(Ropa, id= item_id)
    ropa.delete()
    return redirect('ropa_list')

@login_required
def taza_delete(request, item_id):
    taza = get_object_or_404(Taza, id= item_id)
    taza.delete()
    return redirect('taza_list')

@login_required
def poster_delete(request, item_id):
    poster = get_object_or_404(Poster, id= item_id)
    poster.delete()
    return redirect('poster_list')

@login_required
def accesorio_delete(request, item_id):
    accesorio = get_object_or_404(Accesorio, id= item_id)
    accesorio.delete()
    return redirect('accesorio_list')



@login_required
def accesorio_update(request, item_id):
    accesorio = get_object_or_404(Accesorio, id= item_id)
    if request.method == 'POST':
        form = CreateAccesorioForm(
            request.POST, instance=accesorio)
        if form.is_valid():
            form.save()
            return redirect('accesorio_list')
        else:
            messages.error(request, 'Formulario con errores')

    form = CreateAccesorioForm(instance=accesorio)

    context = {
        'form': form, 
        'title': 'Editar Accesorio',
        'tipo':'Accesorio'
        }

    return render(request, 'create.html', context)

@login_required
def ropa_update(request, item_id):
    ropa = get_object_or_404(Ropa, id= item_id)
    if request.method == 'POST':
        form = CreateRopaForm(
            request.POST, instance=ropa)
        if form.is_valid():
            form.save()
            return redirect('ropa_list')
        else:
            messages.error(request, 'Formulario con errores')

    form = CreateRopaForm(instance=ropa)

    context = {
        'form': form, 
        'title': 'Editar Ropa',
        'tipo':'Ropa'
        }

    return render(request, 'create.html', context)


@login_required
def taza_update(request, item_id):
    taza = get_object_or_404(Taza, id= item_id)
    if request.method == 'POST':
        form = CreateTazaForm(
            request.POST, instance=taza)
        if form.is_valid():
            form.save()
            return redirect('taza_list')
        else:
            messages.error(request, 'Formulario con errores')

    form = CreateTazaForm(instance=taza)

    context = {
        'form': form, 
        'title': 'Editar Taza',
        'tipo':'taza'
        }

    return render(request, 'create.html', context)

@login_required
def poster_update(request, item_id):
    poster = get_object_or_404(Poster, id= item_id)
    if request.method == 'POST':
        form = CreatePosterForm(
            request.POST, instance=poster)
        if form.is_valid():
            form.save()
            return redirect('poster_list')
        else:
            messages.error(request, 'Formulario con errores')

    form = CreatePosterForm(instance=poster)

    context = {
        'form': form, 
        'title': 'Editar Poster',
        'tipo':'Poster'
        }

    return render(request, 'create.html', context)


def obtener_peliculas(peliculas):
    cursor = connection.cursor()
    
    resultado = cursor.callfunc("QUE_PELICULA", cx_Oracle.STRING, [peliculas])
    
    list_peliculas = []
    if resultado :
        for r in resultado.split(","):
            if len(r)>0:
                list_peliculas.append(Pelicula.objects.get(idPelicula=r))

    cursor.close()
    
    return list_peliculas

def obtener_categorias(categorias):
    cursor = connection.cursor()
    
    resultado = cursor.callfunc("QUE_CATEGORIA", cx_Oracle.STRING, [categorias])
    
    list_categorias = []

    if resultado :
        for r in resultado.split(","):
            if len(r)>0:
                list_categorias.append(Categoria.objects.get(idCategoria=r))
    cursor.close()
    
    return list_categorias

def ropa_details(request, item_id):
    item = get_object_or_404(Ropa, id= item_id)
    context = {
        'object': item, 
        'title': item.nombre,
        'item':'Ropa',
        'peliculas': obtener_peliculas(item.pelicula),
        'categorias' : obtener_categorias(item.categoria),
        }

    return render(request, 'details.html', context)

def accesorio_details(request, item_id):
    item = get_object_or_404(Accesorio, id= item_id)
    context = {
        'object': item, 
        'title': item.nombre,
        'item':'Accesorio',
        'peliculas': obtener_peliculas(item.pelicula),
        'categorias' : obtener_categorias(item.categoria),
        }

    return render(request, 'details.html', context)

def taza_details(request, item_id):
    item = get_object_or_404(Taza, id= item_id)
    context = {
        'object': item, 
        'title': item.nombre,
        'item':'Taza',
        'peliculas': obtener_peliculas(item.pelicula),
        'categorias' : obtener_categorias(item.categoria),
        }

    return render(request, 'details.html', context)

def poster_details(request, item_id):
    item = get_object_or_404(Poster, id= item_id)
    
    context = {
        'object': item, 
        'title': item.nombre,
        'item':'Poster',
        'peliculas': obtener_peliculas(item.pelicula),
        'categorias' : obtener_categorias(item.categoria),
        }

    return render(request, 'details.html', context)