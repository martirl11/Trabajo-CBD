from django.shortcuts import render
from .models import *
from .forms import *
from django.contrib import messages
from django.shortcuts import render, redirect



def ropa_create(request):
    form = CreateRopaForm()
    if request.method == 'POST':
        form = CreateRopaForm(request.POST, request.FILES)
        if form.is_valid():
            ropa = form.save(commit=False)
            ropa.save()
            return redirect('item_list')
        else:
            messages.error(request, 'Formulario con errores')

    context = {
        "form": form, 
        "title": "Añadir Ropa", 
        }

    return render(request, 'create.html', context)

def taza_create(request):
    form = CreateTazaForm()
    if request.method == 'POST':
        form = CreateTazaForm(request.POST, request.FILES)
        if form.is_valid():
            taza = form.save(commit=False)
            taza.save()
            return redirect('item_list')
        else:
            messages.error(request, 'Formulario con errores')

    context = {
        "form": form, 
        "title": "Añadir Taza", 
        "item":"accesorio",
        }

    return render(request, 'create.html', context)

def poster_create(request):
    form = CreatePosterForm()
    if request.method == 'POST':
        form = CreatePosterForm(request.POST, request.FILES)
        if form.is_valid():
            poster = form.save(commit=False)
            poster.save()
            return redirect('item_list')
        else:
            messages.error(request, 'Formulario con errores')

    context = {
        "form": form, 
        "title": "Añadir Poster", 
        "item":"accesorio", 
        }

    return render(request, 'create.html', context)

def accesorio_create(request):
    form = CreateAccesorioForm()
    if request.method == 'POST':
        form = CreateAccesorioForm(request.POST, request.FILES)
        if form.is_valid():
            accesorio = form.save(commit=False)
            accesorio.save()
            return redirect('item_list')
        else:
            messages.error(request, 'Formulario con errores')

    context = {
        "form": form, 
        "title": "Añadir Accesorio", 
        "item":"accesorio",
        }

    return render(request, 'create.html', context)
