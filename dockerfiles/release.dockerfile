FROM elixir:1.9-alpine AS builder

ENV APP_NAME=nfl_rushing \
    APP_VERSION=0.1.0 \
    MIX_ENV=prod

WORKDIR /nfl_rushing

# Install build requirements
RUN apk update && \
    apk upgrade --no-cache && \
    apk add --no-cache openssl-dev make build-base gcc git nodejs npm

RUN mix local.rebar --force && \
    mix local.hex --force

# Compile dependencies and application
COPY . .

RUN mix deps.get --only ${MIX_ENV}
RUN mix compile

RUN npm ci --prefix assets
RUN cd assets && npm run deploy

RUN mix phx.digest

# Create a release
RUN mkdir -p /opt/build && \
    mix release && \
    cp -r _build/${MIX_ENV}/rel /opt/build

# STEP 2 - Build application container
FROM alpine:3.9

ARG APP_NAME
ENV APP_NAME=${APP_NAME}

ENV ROOT_FOLDER=/opt

# Update kernel and install runtime dependencies
RUN apk --no-cache update && \
    apk --no-cache upgrade && \
    apk --no-cache add bash openssl

WORKDIR ${ROOT_FOLDER}

COPY --from=builder /opt/build .

COPY dockerfiles/entrypoint.sh /usr/local/bin
RUN chmod a+x /usr/local/bin/entrypoint.sh
RUN mkdir ${ROOT_FOLDER}/logs

# Create a non-root user
RUN adduser -D nfl_rushing && \
    chown -R nfl_rushing: ${ROOT_FOLDER}

USER nfl_rushing

ENTRYPOINT ["entrypoint.sh"]
CMD ["start"]
