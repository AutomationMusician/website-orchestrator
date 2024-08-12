#!/bin/bash

# Run this script using cron:
# 1. open cron using the command `crontab -e`
# 2. Add the following line to the file: 
#    0 * * * * <absolute-path-to>/duckdns-update.sh

SCRIPT_DIR=$(realpath $(dirname $0))
echo $SCRIPT_DIR

source ${SCRIPT_DIR}/.env
LOGS_DIR=${SCRIPT_DIR}/logs/duckdns-update
OUTPUT_FILE=${LOGS_DIR}/$(date '+%Y-%m-%d').txt
echo $OUTPUT_FILE

mkdir -p ${LOGS_DIR}
touch $OUTPUT_FILE
{
    date '+%H:%M:%S' && \
    curl "https://www.duckdns.org/update?domains=${DUCKDNS_DOMAINS}&token=${DUCKDNS_TOKEN}&verbose=true"
} | tr '\n' ',' | tee -a $OUTPUT_FILE
echo "" | tee -a $OUTPUT_FILE
