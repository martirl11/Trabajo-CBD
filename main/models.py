from django.db import models
from django.core.validators import MinValueValidator
from django.forms import ValidationError

TIPO_ROPA = (
    ('Pantalon', 'Pantalón'),
    ('Camisa', 'Camisa'),
    ('Camiseta', 'Camiseta'),
    ('Sudadera', 'Sudadera'),
    ('Abrigo', 'Abrigo'),
    ('Chaqueta', 'Chaqueta'),
    ('Jersey', 'Jersey'),
    ('Falda', 'Falda'),
    ('Otro', 'Otro'),
)

TIPO_POSTER =(
    ('Horizontal', 'Horizontal'),
    ('Vertical', 'Vertical'),
)

class Item (models.Model):
    id=models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=100, verbose_name="Nombre")
    descripcion = models.TextField(verbose_name="Descripción")
    precio = models.DecimalField(max_digits=10, decimal_places=2, validators=[MinValueValidator(0)], verbose_name="Precio (€)")
    imagen = models.ImageField(verbose_name="Imagen", upload_to='./static/img/item/', null=True, blank=True)

    def __str__(self):
        return self.name

    def save(self, *args, **kwargs):

        if self.price < 0:  
            raise ValidationError('El precio no puede ser negativo')
        super(Item, self).save(*args, **kwargs)

class Ropa (Item):
    talla = models.CharField(max_length=3, verbose_name="Talla")
    marca= models.CharField(max_length=100, verbose_name="Marca")
    color = models.CharField(max_length=20, verbose_name="Color")
    tipoRopa = models.CharField(max_length=50,choices=TIPO_ROPA, verbose_name="Tipo de ropa")

    def __str__(self):
        return self.name

class Poster (Item):
    artista = models.CharField(max_length=100, verbose_name="Artista")
    tamano = models.CharField(max_length=100, verbose_name="tamano")
    tipo = models.CharField(max_length=100, choices=TIPO_POSTER, verbose_name="Tipo")

    def __str__(self):
        return self.name

class Taza (Item):
    color = models.CharField(max_length=20, verbose_name="Color")
    capacidad = models.CharField(max_length=20, verbose_name="Capacidad")
    material = models.CharField(max_length=20, verbose_name="Material")
    artista = models.CharField(max_length=100, verbose_name="Artista")

    def __str__(self):
        return self.name

class Accesorio (Item):
    tamano = models.CharField(max_length=50, verbose_name="tamano")
    color = models.CharField(max_length=20, verbose_name="Color")
    material = models.CharField(max_length=50, verbose_name="Material")
    artista = models.CharField(max_length=100, verbose_name="Artista")

    def __str__(self):
        return self.name
