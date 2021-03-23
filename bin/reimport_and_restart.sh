#!/usr/bin/env bash
echo 'Starting agency looper for restart GTFS'
. substitute.sh

# Load in each agency & loop
for filename in /usr/local/transitclock/agencies/*.env; do
  [ -e "$filename" ] || continue
  . "${filename}"

  SECONDARY_RMI="-Dtransitclock.rmi.secondaryRmiPort=0"
  AGENCYID="${ID}" GTFS_URL="${GTFS}" . import_gtfs.sh
  kill -15 $(cat /usr/local/transitclock/${ID}.pid)
  sleep 5
  AGENCYID="${ID}" SECONDARY_RMI="${SECONDARY_RMI}" . start_core.sh
done

echo 'Finished agency looper for restart GTFS'
