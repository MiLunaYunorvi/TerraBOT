#pip install 
import pymysql 
import time
import sys
from datetime import datetime

#argumentos por linea de comandos
# hostaws , user , password 
argumentos = sys.argv

hostaws = argumentos[1]
connection = pymysql.connect(host = hostaws, user = argumentos[2], password= argumentos[3])


def create_table(name):
    with table_connection:
        cur = table_connection.cursor()
        statement = "CREATE TABLE {}(fecha DATE, persona TEXT, consulta TEXT, dominio TEXT)".format(name)
        resp = cur.execute(statement)
        print('respuesta' , resp)
    #show tables


def delete_table(name):
    with connection:
        cur = connection.cursor()
        statement = "DROP TABLE {}".format(name)
        resp = cur.execute(statement)
        print('respuesta' , resp)
    #show tables

def show_table(name):
    with connection:
        cur = connection.cursor()
        statement2= "SELECT * FROM {}".format(name)
        cur.execute(statement2)
        columnas = cur.fetchall()
        print(columnas)


def almacenar_db(name,values):
     with connection:
        cur = connection.cursor()
        #statement = "INSERT INTO {}('sala' , 'fregistro' , 'freserva' , 'hinicio' , 'hfinal' , 'usuario') VALUES (%s,%s,%s,%s,%s,%s)".format(name)
        statement = "INSERT INTO {}(consulta, fecha) VALUES (%s,%s)".format(name)
        response = cur.execute(statement,(values[0],values[1]))
        connection.commit()
        #print(response)
        
def connect_db():
    with connection:
        cur = connection.cursor()
        cur.execute("SELECT VERSION()")
        version = cur.fetchone()
        print("Database version: {} ".format(version[0]))
    
def crear_db(name):
    with connection:
        cur = connection.cursor()
        statement = 'CREATE DATABASE ' + name
        resp = cur.execute(statement)
        print('respuesta' , resp)
        statement2 = "SHOW DATABASES " 
        cur.execute(statement2)
        dblist = cur.fetchall()
        print(dblist)
        #connection.close()
        
def delete_db(name):
    with connection:
        cur = connection.cursor()
        statement = 'DROP DATABASE ' + name
        resp = cur.execute(statement)
        print('respuesta' , resp)
        statement2 = "SHOW DATABASES " 
        cur.execute(statement2)
        dblist = cur.fetchall()
        print(dblist)
        #connection.close()
    
def fechas():
    fecha = time.strftime("%m-%d-%Y")
    hora = time.strftime("%X") 
    fecha_n = datetime.strptime(fecha, '%m-%d-%Y').date()
    hora_n = datetime.strptime(hora,'%H:%M:%S').time()  
    return [fecha_n, hora_n]


#show_table('laboratorio')   

#delete_db('FacesLog')
#connect_db()
crear_db('SecuBotDB')

table_connection = pymysql.connect(host = hostaws, user = argumentos[2], password= argumentos[3],database='SecuBotDB')
create_table('ConsultasLOG')
#delete_table('FacesLog')

#[fecha, hora] = fechas()
#print(fecha, hora)
datos = ['ise', '2023-07-30']
datos1 = ['duo', '2023-07-30']
datos2 = ['duo', '2023-08-01']
datos3 = ['duo', '2023-08-02']
# almacenar_db('ConsultasLOG',datos3)
# almacenar_db('ConsultasLOG',datos2)
# almacenar_db('ConsultasLOG',datos3)
# almacenar_db('ConsultasLOG',datos1)
#connect_db()
#show_table('FacesLog')  