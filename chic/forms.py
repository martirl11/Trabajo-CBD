from django import forms
from .models import *

class CreateRopaForm(forms.ModelForm):

    class Meta:
        model = Ropa
        exclude = ['id']
        widgets = {
            'precio ': forms.NumberInput(attrs={'step': "0.01"}),
            'descripcion': forms.Textarea(attrs={'rows':2}),
            'pelicula': forms.Textarea(attrs={'placeholder':'Debe seguir la siguiente estructura: pelicula1,pelicula2,...','rows':2}),
            'categoria': forms.Textarea(attrs={'placeholder':'Debe seguir la siguiente estructura: categoria1,categoria2,...','rows':2}),
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

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.method = 'GET'
        for field in self.fields:
            if (isinstance(self.fields[field], forms.TypedChoiceField) or isinstance(self.fields[field], forms.ChoiceField)):
                self.fields[field].widget.attrs.update(
                    {'class': 'form-select', 'style': 'display:block'})
            elif (isinstance(self.fields[field], forms.BooleanField)):
                self.fields[field].widget.attrs.update(
                    {'class': 'form-check-input'})
            else:
                self.fields[field].widget.attrs.update(
                    {'class': 'form-control', 'style': 'display:block'})
        
class CreatePosterForm(forms.ModelForm):
    class Meta:
        model = Poster
        exclude = ['id']
        widgets = {
            'precio ': forms.NumberInput(attrs={'step': "0.01"}),
            'descripcion': forms.Textarea(attrs={'rows':2}),
            'pelicula': forms.Textarea(attrs={'placeholder':'Debe seguir la siguiente estructura: pelicula1,pelicula2,...','rows':2}),
            'categoria': forms.Textarea(attrs={'placeholder':'Debe seguir la siguiente estructura: categoria1,categoria2,...','rows':2}),
        }
        error_messages = {
            'nombre': {
                'required': 'Por favor ingrese el nombre del artículo.',
            },
            'precio ': {
                'required': 'Por favor ingrese el precio del artículo.',
            },
            'tamano': {
                'required': 'Por favor ingrese el tamano del artículo.',
            },
            
        }
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.method = 'GET'
        for field in self.fields:
            if (isinstance(self.fields[field], forms.TypedChoiceField) or isinstance(self.fields[field], forms.ChoiceField)):
                self.fields[field].widget.attrs.update(
                    {'class': 'form-select', 'style': 'display:block'})
            elif (isinstance(self.fields[field], forms.BooleanField)):
                self.fields[field].widget.attrs.update(
                    {'class': 'form-check-input'})
            else:
                self.fields[field].widget.attrs.update(
                    {'class': 'form-control', 'style': 'display:block'})
        
class CreateAccesorioForm(forms.ModelForm):
    class Meta:
        model = Accesorio
        exclude = ['id']
        widgets = {
            'precio ': forms.NumberInput(attrs={'step': "0.01"}),
            'descripcion': forms.Textarea(attrs={'rows':2}),
            'pelicula': forms.Textarea(attrs={'placeholder':'Debe seguir la siguiente estructura: pelicula1,pelicula2,...','rows':2}),
            'categoria': forms.Textarea(attrs={'placeholder':'Debe seguir la siguiente estructura: categoria1,categoria2,...','rows':2}),
        }
        error_messages = {
            'nombre': {
                'required': 'Por favor ingrese el nombre del artículo.',
            },
            'precio ': {
                'required': 'Por favor ingrese el precio del artículo.',
            },
            'tamano': {
                'required': 'Por favor ingrese el tamano del artículo.',
            },
            
        }
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.method = 'GET'
        for field in self.fields:
            if (isinstance(self.fields[field], forms.TypedChoiceField) or isinstance(self.fields[field], forms.ChoiceField)):
                self.fields[field].widget.attrs.update(
                    {'class': 'form-select', 'style': 'display:block'})
            elif (isinstance(self.fields[field], forms.BooleanField)):
                self.fields[field].widget.attrs.update(
                    {'class': 'form-check-input'})
            else:
                self.fields[field].widget.attrs.update(
                    {'class': 'form-control', 'style': 'display:block'})
        
class CreateTazaForm(forms.ModelForm):
    class Meta:
        model = Taza
        exclude = ['id']
        widgets = {
            'precio ': forms.NumberInput(attrs={'step': "0.01"}),
            'descripcion': forms.Textarea(attrs={'rows':2}),
            'pelicula': forms.Textarea(attrs={'placeholder':'Debe seguir la siguiente estructura: pelicula1,pelicula2,...','rows':2}),
            'categoria': forms.Textarea(attrs={'placeholder':'Debe seguir la siguiente estructura: categoria1,categoria2,...','rows':2}),
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
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.method = 'GET'
        for field in self.fields:
            if (isinstance(self.fields[field], forms.TypedChoiceField) or isinstance(self.fields[field], forms.ChoiceField)):
                self.fields[field].widget.attrs.update(
                    {'class': 'form-select', 'style': 'display:block'})
            elif (isinstance(self.fields[field], forms.BooleanField)):
                self.fields[field].widget.attrs.update(
                    {'class': 'form-check-input'})
            else:
                self.fields[field].widget.attrs.update(
                    {'class': 'form-control', 'style': 'display:block'})