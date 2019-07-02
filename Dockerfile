FROM python:3

LABEL maintainer="TBD"

ENV APP_DIR=/home/docker/DEPTool
ENV API_TOKEN=yoursecret
ENV SERVER_URL=https://yourdomain.com

RUN pip install --no-cache-dir django

COPY /api/ ${APP_DIR}/api
COPY /configs/ ${APP_DIR}/configs
COPY /DEP/ ${APP_DIR}/DEP
COPY manage.py ${APP_DIR}/manage.py

# Need to do this until a unified run-level script is made.
COPY docker_sync_dep.sh ${APP_DIR}/run_as_munkiadmin.sh
COPY docker_sync_dep.sh ${APP_DIR}/sync_dep_devices.sh

RUN chmod +x ${APP_DIR}/manage.py \
    && mkdir -p /home/app \
    && ln -s ${APP_DIR} /home/app/DEPTool

WORKDIR ${APP_DIR}

EXPOSE 8080

VOLUME $APP_DIR/keyset

CMD ["./manage.py runserver 0.0.0.0:8080"]
