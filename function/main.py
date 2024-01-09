import json
import os

from google.cloud.sql.connector import Connector, IPTypes


def dump(x):
    print(json.dumps(x, default=repr))


def handler(request, **kwargs):
    conn = Connector().connect(
        os.environ['DB_CONNECTION'],
        "pg8000",
        user=os.environ['DB_USER'],
        password=os.environ['DB_PASSWORD'].strip(),
        db=os.environ['DB_DATABASE'],
        ip_type=IPTypes.PUBLIC,
    )
    cur = conn.cursor()
    cur.execute('SELECT tablename FROM pg_catalog.pg_tables')
    rows = cur.fetchall()
    cur.close()
    conn.close()

    dump(rows)
    dump(request.__dict__)
    dump(kwargs)
    return "Hello World!"
