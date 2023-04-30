#encoding:utf-8
from .models import Usuario, Ocupacion, Puntuacion, Pelicula, Categoria
from chic.models import *
from datetime import datetime

path = "data"

def populate():
    o=populateOccupations()
    g=populateGenres()
    (u, us)=populateUsers()
    (m, mo)=populateMovies()
    p=populateRatings(u,m)
    #t=populateTaza()
    r=porblar_merchan()
    #po=populatePoster()
    #a=populateAccesorio()#USAMOS LOS DICCIONARIOS DE USUARIOS Y PELICULAS PARA ACELERAR LA CARGA EN PUNTUACIONES
    return (o,g,us,mo,p,r)

def populateOccupations():
    Ocupacion.objects.all().delete()
    
    lista=[]
    fileobj=open(path+"\\u.occupation", "r")
    for line in fileobj.readlines():
        lista.append(Ocupacion(nombre=str(line.strip())))
    fileobj.close()
    Ocupacion.objects.bulk_create(lista)  # bulk_create hace la carga masiva para acelerar el proceso
    
    return Ocupacion.objects.count()

def populateGenres():
    Categoria.objects.all().delete()
    
    lista=[]
    fileobj=open(path+"\\u.genre", "r")
    for line in fileobj.readlines():
        rip = str(line.strip()).split('|')
        if len(rip) != 2:
            continue
        lista.append(Categoria(idCategoria=int(rip[1]), nombre=rip[0]))
    fileobj.close()
    Categoria.objects.bulk_create(lista)
    
    return Categoria.objects.count()

def populateUsers():
    Usuario.objects.all().delete()
    
    lista=[]
    dict={} # diccionario de los usuarios {idusuario:objeto_usuario}
    fileobj=open(path+"\\u.user", "r")
    for line in fileobj.readlines():
        rip = str(line.strip()).split('|')
        if len(rip) != 5:
            continue
        u=Usuario(idUsuario=int(rip[0]), edad=int(rip[1]), sexo=rip[2], ocupacion=Ocupacion.objects.get(nombre=rip[3]), codigoPostal=rip[4])
        lista.append(u)
        dict[int(rip[0])]=u
    fileobj.close()
    Usuario.objects.bulk_create(lista)
    
    return(dict, Usuario.objects.count())

def populateMovies():
    Pelicula.objects.all().delete()
    
    lista_peliculas =[]  # lista de peliculas
    dict_categorias={}  #  diccionario de categorias de cada pelicula (idPelicula y lista de categorias)
    fileobj=open(path+"\\u.item", "r")
    for line in fileobj.readlines():
        rip = line.strip().split('|')
        
        date = None if len(rip[2]) == 0 else datetime.strptime(rip[2], '%d-%b-%Y')
        lista_peliculas.append(Pelicula(idPelicula=int(rip[0]), titulo=rip[1], fechaEstreno=date, imdbUrl=rip[4]))
        
        lista_aux=[]
        for i in range(5, len(rip)):
            if rip [i] == '1':
                lista_aux.append(Categoria.objects.get(pk = (i-5)))
        dict_categorias[int(rip[0])]=lista_aux
    fileobj.close()    
    Pelicula.objects.bulk_create(lista_peliculas)

    dict={} # diccionario de las pel�culas {idpelicula:objeto_pelicula}
    for pelicula in Pelicula.objects.all():
        #aqu� se a�aden las categorias a cada pel�cula
        pelicula.categorias.set(dict_categorias[pelicula.idPelicula])
        dict[pelicula.idPelicula]=pelicula
    
    return(dict, Pelicula.objects.count())

def populateRatings(u,m):
    # usamos los diccionarios de usuarios y pel�culas para acelerar la creaci�n de las puntuaciones
    # evitando tener que acceder a las tablas de Usuario y Pelicula
    Puntuacion.objects.all().delete()

    lista=[]
    fileobj=open(path+"\\u.data", "r")
    for line in fileobj.readlines():
        rip = str(line.strip()).split('\t')
        lista.append(Puntuacion(idUsuario=u[int(rip[0])], idPelicula=m[int(rip[1])], puntuacion=int(rip[2])))
    fileobj.close()
    Puntuacion.objects.bulk_create(lista)

    return Puntuacion.objects.count()

import cx_Oracle

dsn_tns = cx_Oracle.makedsn('localhost', '1521', service_name='orcl.home')
connection = cx_Oracle.connect(user="root_cbd_2", password="trabaj0CBD", dsn=dsn_tns)
  
   

def porblar_merchan():
    cursor = connection.cursor()
    
    cursor.callproc("POBLAR_MERCHAN", [])
    connection.commit()
    connection.close()
    

    

