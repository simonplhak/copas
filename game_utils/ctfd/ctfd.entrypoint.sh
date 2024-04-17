#!/bin/sh
/ctfd/env/bin/flask db upgrade

exec /ctfd/env/bin/gunicorn wsgi:app --bind "0.0.0.0:$CTFD_PORT" --chdir /ctfd --workers 4
