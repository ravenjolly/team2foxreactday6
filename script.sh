#!/bin/sh
# line endings must be \n, not \r\n !
echo "REACT_APP_API_IP="$REACT_APP_API_IP > /env.prepared
echo "REACT_APP_AUTH_IP="$REACT_APP_AUTH_IP >> /env.prepared

echo "window._env_ = {" > ./env-config.js
awk -F '=' '{ print $1 ": \"" (ENVIRON[$1] ? ENVIRON[$1] : $2) "\"," }' /env.prepared >> ./env-config.js
echo "}" >> ./env-config.js

envsubst '\$REACT_APP_AUTH_IP \$REACT_APP_API_IP' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf
nginx -g 'daemon off;'
