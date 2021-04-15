#!/bin/bash
# Expected to run from the root repository.
set -eux
command -v jq >/dev/null 2>/dev/null || ( apt-get update && apt-get install -y jq )
CWD=$(pwd)
npx eslint ./testdata/*.js -f ./eslint-formatter-rdjson/index.js \
  | jq . \
  | sed -e "s!${CWD}/!!g" \
  > eslint-formatter-rdjson/testdata/result.out
diff -u eslint-formatter-rdjson/testdata/result.*
