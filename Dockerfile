FROM tomsquest/docker-radicale:3.5.1.0

ARG COMMIT_ID
ENV COMMIT_ID=${COMMIT_ID}

ARG BUILD_UID
ENV BUILD_UID=${BUILD_UID:-2999}

ARG BUILD_GID
ENV BUILD_GID=${BUILD_GID:-2999}

ARG VERSION
ENV VERSION=${VERSION:-0.0.1}

LABEL maintainer="Christof Schulze <christof@christofschulze.com>" \
      org.label-schema.name="Radicale Docker Image with birthday script" \
      org.label-schema.description="Enhanced Docker image for Radicale, the CalDAV/CardDAV server with capabilities to generate birthday calendar from the address books" \
      org.label-schema.url="https://github.com/christf/docker-radicale-bd" \
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-ref=$COMMIT_ID \
      org.label-schema.vcs-url="https://github.com/tomsquest/docker-radicale" \
      org.label-schema.schema-version="1.0"

# TODO: It would be nice to have a well-defined release for this for reproducible builds
RUN curl -o /usr/local/bin/create_birthday_calendar.py https://raw.githubusercontent.com/iBigQ/radicale-birthday-calendar/refs/heads/main/create_birthday_calendar.py && \
    chmod +x /usr/local/bin/create_birthday_calendar.py

RUN apk add --no-cache \
        py3-dateutil \
        py3-vobject \
        py3-pip \
    && rm -fr /root/.cache

