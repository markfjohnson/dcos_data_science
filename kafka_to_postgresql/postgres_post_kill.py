import psycopg2
import sys
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

con = None
host = "54.70.177.30"
psql_port = "15432"

try:
    con = psycopg2.connect("host='{}' dbname='test_db' user='admin' password='password' port={}".format(host,psql_port))

    con.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
    cur = con.cursor()

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