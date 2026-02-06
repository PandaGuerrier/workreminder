FROM dart:stable AS build

WORKDIR /app

WORKDIR /app/workreminder

# Installer les dépendances
RUN dart pub get

# Compiler en AOT pour la production
RUN dart compile exe bin/main.dart -o bin/bot

# Image de production légère
FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copier l'exécutable compilé
COPY --from=build /app/exemples/workreminder/bin/bot /app/bot

# Variables d'environnement (à configurer dans Dokploy)
ENV DART_ENV=production
ENV TOKEN=""
ENV CHANNEL_ID=""
ENV DISCORD_REST_API_VERSION=10
ENV DISCORD_WS_VERSION=10
ENV DISCORD_WS_ENCODING=etf
ENV INTENT=3276799
ENV LOG_LEVEL=INFO

CMD ["/app/bot"]
