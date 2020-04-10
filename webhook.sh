#!/bin/sh

cd /source
rm -rf ..?* .[!.]* *

echo "git clone code start"
git clone $GITHUB_REPO .; git pull
echo "git clone code end"

echo "build start"
npm install && npm run build || (echo "Build failed. Aborting!"; exit 1)
echo "Build Done!"

echo "Copying files..."
rsync -q -r --delete public/ /output/