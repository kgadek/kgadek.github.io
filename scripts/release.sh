#!/bin/sh
set -euxo pipefail

export DEVELOP_BRANCH="develop"
export MAIN_BRANCH="main"

export MAIN_HASH="$(git rev-parse "${MAIN_BRANCH}")"
export DEVELOP_HASH="$(git rev-parse "${DEVELOP_BRANCH}")"
export DEVELOP_HASH_SHORT="$(git rev-parse --short "${DEVELOP_BRANCH}")"
export DEVELOP_COMMITDATE="$(git log -1 --format=%cd "${DEVELOP_BRANCH}")"
export DEVELOP_PUBLIC_TREE="$(git rev-parse "${DEVELOP_BRANCH}^{tree}:public/")"
export NEW_COMMIT="$(git commit-tree -m "Deploy from ${DEVELOP_BRANCH} SHA1:${DEVELOP_HASH_SHORT} (${DEVELOP_COMMITDATE})" -p "${MAIN_HASH}" -p "${DEVELOP_HASH}" "${DEVELOP_PUBLIC_TREE}")"

git checkout "${MAIN_BRANCH}"
git reset --hard "${NEW_COMMIT}"

