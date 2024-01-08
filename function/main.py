import json
import os


def dump(x):
    print(json.dumps(x, default=repr))


def handler(request, **kwargs):
    import psycopg2
    conn = psycopg2.connect(
        host=os.environ['DB_IP'].strip(),
        user='postgres',
        password=os.environ['DB_PASSWORD'].strip(),
        dbname='postgres'
    )
    with conn.cursor() as cur:
        cur.execute('SELECT * FROM your_table')
        rows = cur.fetchall()
    conn.close()

    dump(rows)
    dump(request.__dict__)
    return "Hello World!"
