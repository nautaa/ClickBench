#!/bin/bash

TRIES=1
TIMEFORMAT='%3R'

if [ ! -z "$1" ]; then
    SOCKET_FILE="$1"
else
exit 1
fi

cat queries.sql | while read -r query; do
    sync
    echo 3 | sudo tee /proc/sys/vm/drop_caches >/dev/null 2>&1

    for i in $(seq 1 $TRIES); do
         echo "${query}"
         time mysql -S $SOCKET_FILE -e "SET execution_mode = 'chunk_iterator'; ${query}" >/dev/null 2>&1;
    done;
done;