#!/bin/sh -e
nginx -t
service nginx reload
service nginx start
/opt/focalboard/bin/focalboard-server
