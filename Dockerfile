# Run the official Bifrost gateway image; this repository contains deployment
# configuration only, not a fork of the upstream Bifrost source code.
FROM maximhq/bifrost:v2.6.0

ENV APP_HOST=0.0.0.0 \
    APP_PORT=8080 \
    APP_DIR=/app/data \
    LOG_LEVEL=info \
    LOG_STYLE=json
