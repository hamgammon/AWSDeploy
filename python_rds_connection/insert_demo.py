import mysql.connector

host = 'database-1.c3ivlsodbshb.us-east-1.rds.amazonaws.com'
username = 'admin'
password = '01K0geplRHYB3zZJmUjk'

conn = mysql.connector.connect(host=host, username=username, password=password, database='demoDB' )
conn.autocommit = True
cursor = conn.cursor()

insert_command = "insert into emp values (%d, '%s', %.2f)" % (101, 'John', 12500.00)
cursor.execute(insert_command)
print(cursor.rowcount, 'row(s) inserted')

conn.close()