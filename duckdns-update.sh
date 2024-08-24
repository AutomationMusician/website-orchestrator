#!/bin/bash

# Run this script using cron:
# 1. open cron using the command `crontab -e`
# 2. Add the following line to the file to run it every hour (at the 55 minute mark): 
#    55 * * * * <absolute-path-to>/duckdns-update.sh

SCRIPT_DIR=$(realpath $(dirname $0))
source ${SCRIPT_DIR}/.env
LOGS_DIR=${SCRIPT_DIR}/logs/duckdns-update
OUTPUT_FILE=${LOGS_DIR}/$(date '+%Y-%m-%d').txt

mkdir -p ${LOGS_DIR}
touch $OUTPUT_FILE
{
    date '+%H:%M:%S' && \
    curl "https://www.duckdns.org/update?domains=${DUCKDNS_DOMAINS}&token=${DUCKDNS_TOKEN}&verbose=true"
} | tr '\n' ',' | tee -a $OUTPUT_FILE
echo "" | tee -a $OUTPUT_FILE
