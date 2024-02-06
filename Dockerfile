FROM python:3.8-slim-bullseye

ENV RELSTORAGE_VERSION="3.4.0"

RUN useradd --system -m -d /relstorage -U -u 500 relstorage && \
    buildDeps="gcc libc6-dev libpq-dev" && \
    runDeps="nano screen postgresql-client-15" && \
    apt-get update && \
    apt-get install -y --no-install-recommends $buildDeps && \
    pip install RelStorage[postgresql]==$RELSTORAGE_VERSION && \
    apt-get purge -y --auto-remove $buildDeps && \
    apt-get install -y --no-install-recommends $runDeps && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /relstorage
USER relstorage

COPY --chown=relstorage to_relstorage.zcml from_relstorage.zcml ./

CMD [ "/bin/bash" ]

