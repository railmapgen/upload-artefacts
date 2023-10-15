#!/bin/bash
set -eux

tar -czvf "$VERSION".tar.gz --directory "$DIST" .

MESSAGE="Build version $APP_NAME-$VERSION"
cat >payload.json <<EOF
{
  "message": "$MESSAGE",
  "committer": {
    "name": "github-actions[bot]",
    "email": "github-actions[bot]@users.noreply.github.com"
  },
  "content": "$(base64 -i $VERSION.tar.gz)"
}
EOF

echo $TOKEN | gh auth login --with-token
gh api -X PUT /repos/uat-railmapgen/rmg-repositories/contents/$APP_NAME/$VERSION.tar.gz --input payload.json
