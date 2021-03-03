#!/bin/bash

# Start MySQL in background process
/usr/local/bin/docker-entrypoint.sh "$@" &
MYSQL_PID=$!

# Initialize config monitor if enabled
if echo "${DATAJOINT_DATABASE_CONFIG_MONITOR}" | grep -i true &>/dev/null; then
	echo "[$(date -u '+%Y-%m-%d %H:%M:%S')][DataJoint]: Monitoring MySQL config changes..."
	INIT_TIME=$(date +%s)
	LAST_MOD_TIME=$(date -r /etc/mysql/my.cnf +%s)
	DELTA=$(expr $LAST_MOD_TIME - $INIT_TIME)
	while true; do
		CURR_FILEPATH=$(ls -t /etc/mysql/my.cnf | head -n 1)
		CURR_LAST_MOD_TIME=$(date -r /etc/mysql/my.cnf +%s)
		CURR_DELTA=$(expr $CURR_LAST_MOD_TIME - $INIT_TIME)
		if [ "$DELTA" -lt "$CURR_DELTA" ]; then
			echo "[$(date -u '+%Y-%m-%d %H:%M:%S')][DataJoint]: Config Update: \
				Reloading MySQL since \`$CURR_FILEPATH\` changed." | \
				tr -d '\n' | tr -d '\t'
			kill "${MYSQL_PID}"
			/usr/local/bin/docker-entrypoint.sh "$@" &
			MYSQL_PID=$!
			DELTA=$CURR_DELTA
		else
			sleep 1
		fi
	done
else
	tail -f /dev/null
fi
