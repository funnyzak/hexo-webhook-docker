#!/bin/sh
set -eo pipefail

cd /source
git clone https://$GITHUB_REPO . && git pull

npm install && npm run build || (echo "Build failed. Aborting!"; exit 1)
echo "Done!"