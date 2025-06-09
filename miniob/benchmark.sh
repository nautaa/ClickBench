#!/bin/bash

# usages: ./benchmark.sh ${observer_bin} ${socket_file} ${data_file}
# example: ./benchmark.sh /data/miniob/build_debug/bin/ /tmp/miniob.sock /data/clickdata/tmp.csv

if [ ! -z "$1" ]; then
    OBSERVER_BIN="$1"
else
exit 1
fi

if [ ! -z "$2" ]; then
    SOCKET_FILE="$2"
else
exit 1
fi

if [ ! -z "$3" ]; then
    DATA_FILE="$3"
else
exit 1
fi

# Start MiniOB
nohup $OBSERVER_BIN/observer -P mysql -s $SOCKET_FILE > /dev/null 2>&1 &

sleep 3
# Load the data

mysql -S $SOCKET_FILE < create.sql

echo "load data infile \"$DATA_FILE\" into table hits fields terminated by \",\" enclosed by '\"';" | mysql -S $SOCKET_FILE

# if [ ! -f hits.tsv ]
# then
#     wget --no-verbose --continue 'https://datasets.clickhouse.com/hits_compatible/hits.tsv.gz'
#     gzip -d -f hits.tsv.gz
# fi

# Run the queries

./run.sh $SOCKET_FILE
