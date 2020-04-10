#!/bin/sh
set -eo pipefail

cd /source
if [ -n "$GITHUB_TOKEN" ]; then
    git clone https://$GITHUB_TOKEN@$GITHUB_REPO .; git pull
else
    git clone https://$GITHUB_REPO .; git pull
fi

npm install && npm run build || (echo "Build failed. Aborting!"; exit 1)
echo "Done!"