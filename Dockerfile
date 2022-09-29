FROM casjaysdevdocker/nodejs:latest as build

ARG LICENSE=WTFPL \
  IMAGE_NAME=link-warden \
  TIMEZONE=America/New_York \
  PORT="2500 5500"

ENV SHELL=/bin/bash \
  TERM=xterm-256color \
  HOSTNAME=${HOSTNAME:-casjaysdev-$IMAGE_NAME} \
  TZ=$TIMEZONE

RUN mkdir -p /bin/ /config/ /data/ && \
  rm -Rf /bin/.gitkeep /config/.gitkeep /data/.gitkeep && \
  apk update -U --no-cache && \
  apk add --no-cache nodejs && \
  git clone -q https://github.com/Daniel31x13/link-warden /app && \
  cd /app && npm i -g npm@latest npm ci --legacy-peer-deps

COPY ./bin/. /usr/local/bin/
COPY ./config/. /config/
COPY ./data/. /data/

FROM scratch
ARG BUILD_DATE="$(date +'%Y-%m-%d %H:%M')"

LABEL org.label-schema.name="link-warden" \
  org.label-schema.description="Containerized version of link-warden" \
  org.label-schema.url="https://hub.docker.com/r/casjaysdevdocker/link-warden" \
  org.label-schema.vcs-url="https://github.com/casjaysdevdocker/link-warden" \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.version=$BUILD_DATE \
  org.label-schema.vcs-ref=$BUILD_DATE \
  org.label-schema.license="$LICENSE" \
  org.label-schema.vcs-type="Git" \
  org.label-schema.schema-version="latest" \
  org.label-schema.vendor="CasjaysDev" \
  maintainer="CasjaysDev <docker-admin@casjaysdev.com>"

ENV SHELL="/bin/bash" \
  TERM="xterm-256color" \
  HOSTNAME="casjaysdev-link-warden" \
  TZ="${TZ:-America/New_York}" \
  CLIENT_PORT=2500 \
  API_PORT=5700 \
  API_ADDRESS=localhost

WORKDIR /root

VOLUME ["/root","/config","/data"]

EXPOSE $PORT

COPY --from=build /. /

ENTRYPOINT [ "tini", "--" ]
HEALTHCHECK CMD [ "/usr/local/bin/entrypoint-link-warden.sh", "healthcheck" ]
CMD [ "/usr/local/bin/entrypoint-link-warden.sh" ]
