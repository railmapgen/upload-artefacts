#!/bin/bash
set -eux

# git config
git config --global user.name 'github-actions[bot]'
git config --global user.email 'github-actions[bot]@users.noreply.github.com'

mkdir -p ./repo/"$APP_NAME"/
tar -czvf "$VERSION".tar.gz --directory "$VERSION" .
cp "$VERSION".tar.gz ./repo/"$APP_NAME"/

cd ./repo/
git add .
git commit -m "Build version $APP_NAME-$VERSION"
{
  git push
} || {
  git pull --rebase
  git push
}
