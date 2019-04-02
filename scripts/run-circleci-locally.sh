#!/bin/sh
set -euo pipefail

: ${CIRCLE_TOKEN:?}

curl --user "${CIRCLE_TOKEN}:" \
    --request POST \
    --form revision="$(git rev-parse HEAD)" \
    --form config=@.circleci/config.yml \
    --form notify=false \
    "https://circleci.com/api/v1.1/project/github/kgadek/kgadek.github.io/tree/$(git rev-parse --abbrev-ref HEAD)"
