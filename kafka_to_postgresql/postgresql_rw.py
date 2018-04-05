import psycopg2
import sys
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

con = None
host = "54.70.177.30"
psql_port = "15432"

try:
    con = psycopg2.connect("host='{}' dbname='postgres' user='admin' password='password' port={}".format(host,psql_port))

    con.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
    cur = con.cursor()
    cur.execute("DROP TABLE IF EXISTS link;")
    cur.execute("DROP DATABASE IF EXISTS test_db")

#    cur.execute("CREATE ROLE test_user with LOGIN CREATEDB PASSWORD 'somepassword';")
    cur.execute("CREATE DATABASE test_db;")
#    cur.execute("GRANT ALL PRIVILEGES ON DATABASE test_user to clair;")
    cur.execute("CREATE TABLE link (ID serial PRIMARY KEY, url VARCHAR (255) NOT NULL, name VARCHAR (255) NOT NULL,"
                + "description VARCHAR (255),rel VARCHAR(50)); ")
    cur.execute("INSERT INTO link (url, name) VALUES('http://www.postgresqltutorial.com','PostgreSQL Tutorial');")
    cur.execute("SELECT * FROM link;")
    rows = cur.fetchall()
    print "\nShow me the Rows:\n"
    for row in rows:
        print "{}, {}".format(row[1],row[2])

    con.commit()
except psycopg2.DatabaseError, e:
    if con:
        con.rollback()

    print 'Error %s' % e
    sys.exit(1)

finally:
    if con:
        con.close()