APIURL=${APIURL:-http://social.test.nevervictimconsult.xyz:8080/api}

npx newman run Conduit-setup.postman_collection.json \
  --delay-request 100 \
  --iteration-count 100 \
  --verbose \
  --global-var "APIURL=$APIURL" \
  "$@"