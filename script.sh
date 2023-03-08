#!/bin/sh
# line endings must be \n, not \r\n !
echo "REACT_APP_API_IP="$REACT_APP_API_IP > /env.prepared
echo "REACT_APP_AUTH_IP="$REACT_APP_AUTH_IP >> /env.prepared


envsubst '\$REACT_APP_AUTH_IP \$REACT_APP_API_IP' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf
nginx -g 'daemon off;'
