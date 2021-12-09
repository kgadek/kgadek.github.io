#!/bin/sh
set -euxo pipefail

DOCKER_REPO="kgadek/kgadek.github.io"
ZOLA_VER="v0.15.1"

docker build --build-arg ZOLA_VER="${ZOLA_VER}" -t "${DOCKER_REPO}:${ZOLA_VER}" .

set +x
cat <<EOF

###################################################
##                                               ##
## Check the resulting image, then:              ##
##                                               ##
##   docker push kgadek/kgadek.github.io:${ZOLA_VER} ##
##                                               ##
###################################################
EOF
