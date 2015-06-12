#!/bin/bash -xe
nginx -t -c /etc/nginx/nginx.conf && service nginx reload
exit $?
