import mysql.connector

host = 'database-1.c3ivlsodbshb.us-east-1.rds.amazonaws.com'
username = 'admin'
password = '01K0geplRHYB3zZJmUjk'

conn = mysql.connector.connect(host=host, username=username, password=password, database='demoDB')

print('Connection Ready')

conn.close()