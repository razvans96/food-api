# Etapa de build
FROM dart:stable AS build

WORKDIR /app

# Resolve app dependencies.
COPY pubspec.* ./
RUN dart pub get

# Copy app source code and AOT compile it.
COPY . .

# Generate a production build.
RUN dart pub global activate dart_frog_cli
RUN dart pub global run dart_frog_cli:dart_frog build

# Ensure packages are still up-to-date if anything has changed.
RUN dart pub get --offline
RUN dart compile exe build/bin/server.dart -o build/bin/server

# Production image
FROM gcr.io/distroless/cc

WORKDIR /app
COPY --from=build /runtime/ /
COPY --from=build /app/build/bin/server /app/bin/

CMD ["/app/bin/server"]
