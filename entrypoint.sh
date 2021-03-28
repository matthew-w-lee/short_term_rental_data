#!/bin/bash

set -e

#remove a potentially pre-existing server.pid for rails
rm -f /app/tmp/pids/server.pid

#then execute the container's main process
exec "$@"