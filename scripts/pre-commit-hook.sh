#!/bin/sh
set -euxo pipefail

zola build
git add public/
