FROM python:3.8-slim-buster

RUN useradd --system -m -d /relstorage -U -u 500 relstorage && \
    buildDeps="gcc libc6-dev libpq-dev" && \
    runDeps="nano screen postgresql-client" && \
    apt-get update && \
    apt-get install -y --no-install-recommends $buildDeps && \
    pip install RelStorage[postgresql]==3.4.0 && \
    apt-get purge -y --auto-remove $buildDeps && \
    apt-get install -y --no-install-recommends $runDeps && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /relstorage
USER relstorage

CMD [ "/bin/bash" ]

