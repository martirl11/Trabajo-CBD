from django import forms
from .models import *

class CreateRopaForm(forms.ModelForm):
    class Meta:
        model = Ropa
        exclude = ['id']
        widgets = {
            'precio ': forms.NumberInput(attrs={'step': "0.01"}),
            'pelicula': forms.Textarea(attrs={'placeholder':'Debe seguir la siguiente estructura: pelicula1,pelicula2,...'}),
            'categoria': forms.Textarea(attrs={'placeholder':'Debe seguir la siguiente estructura: categoria1,categoria2,...'}),
        }   
        error_messages = {
            'nombre': {
                'required': 'Por favor ingrese el nombre del artículo.',
            },
            'precio ': {
                'required': 'Por favor ingrese el precio del artículo.',
            },
            'talla': {
                'required': 'Por favor ingrese la talla del artículo.',
            },
            
        }
        
class CreatePosterForm(forms.ModelForm):
    class Meta:
        model = Poster
        exclude = ['id']
        widgets = {
            'precio ': forms.NumberInput(attrs={'step': "0.01"}),
            'pelicula': forms.Textarea(attrs={'placeholder':'Debe seguir la siguiente estructura: pelicula1,pelicula2,...'}),
            'categoria': forms.Textarea(attrs={'placeholder':'Debe seguir la siguiente estructura: categoria1,categoria2,...'}),
        }
        error_messages = {
            'nombre': {
                'required': 'Por favor ingrese el nombre del artículo.',
            },
            'precio ': {
                'required': 'Por favor ingrese el precio del artículo.',
            },
            'tamaño': {
                'required': 'Por favor ingrese el tamaño del artículo.',
            },
            
        }
        
class CreateAccesorioForm(forms.ModelForm):
    class Meta:
        model = Accesorio
        exclude = ['id']
        widgets = {
            'precio ': forms.NumberInput(attrs={'step': "0.01"}),
            'pelicula': forms.Textarea(attrs={'placeholder':'Debe seguir la siguiente estructura: pelicula1,pelicula2,...'}),
            'categoria': forms.Textarea(attrs={'placeholder':'Debe seguir la siguiente estructura: categoria1,categoria2,...'}),
        }
        error_messages = {
            'nombre': {
                'required': 'Por favor ingrese el nombre del artículo.',
            },
            'precio ': {
                'required': 'Por favor ingrese el precio del artículo.',
            },
            'tamaño': {
                'required': 'Por favor ingrese el tamaño del artículo.',
            },
            
        }
        
class CreateTazaForm(forms.ModelForm):
    class Meta:
        model = Taza
        exclude = ['id']
        widgets = {
            'precio ': forms.NumberInput(attrs={'step': "0.01"}),
            'pelicula': forms.Textarea(attrs={'placeholder':'Debe seguir la siguiente estructura: pelicula1,pelicula2,...'}),
            'categoria': forms.Textarea(attrs={'placeholder':'Debe seguir la siguiente estructura: categoria1,categoria2,...'}),
        }
        error_messages = {
            'nombre': {
                'required': 'Por favor ingrese el nombre del artículo.',
            },
            'precio ': {
                'required': 'Por favor ingrese el precio del artículo.',
            },
            'capacidad': {
                'required': 'Por favor ingrese la capacidad del artículo.',
            },
            
        }