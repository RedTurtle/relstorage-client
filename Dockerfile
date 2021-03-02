FROM python:3.8-slim-buster

ENV RELSTORAGE_VERSION="3.4.0"

RUN useradd --system -m -d /relstorage -U -u 500 relstorage && \
    buildDeps="gcc gnupg2 libc6-dev libpq-dev lsb-release wget" && \
    runDeps="nano screen postgresql-client-12" && \
    apt-get update && \
    apt-get install -y --no-install-recommends $buildDeps && \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list && \
    pip install RelStorage[postgresql]==$RELSTORAGE_VERSION && \
    apt-get update && \
    apt-get purge -y --auto-remove $buildDeps && \
    apt-get install -y --no-install-recommends $runDeps && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /relstorage
USER relstorage

COPY --chown=relstorage to_relstorage.zcml from_relstorage.zcml ./

CMD [ "/bin/bash" ]

