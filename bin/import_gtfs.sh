#!/usr/bin/env bash
echo "THETRANSITCLOCK DOCKER: Import GTFS file for ${AGENCYID}"
. substitute.sh

DIR="/usr/local/transitclock/gtfs/${AGENCYID}/"
SUPPLEMENT="$DIR/supplement"

mkdir -p $DIR

if [ -z "$(ls -A $DIR)" ]; then
	wget -O "/tmp/gtfs.zip" "${GTFS_URL}"
	unzip -d $DIR "/tmp/gtfs.zip"
	mkdir -p "$DIR/supplement/"
fi

java \
  -Dtransitclock.logging.dir=/tmp \
  -Dtransitclock.configFiles="/usr/local/transitclock/config/${AGENCYID}.properties" \
  -cp /usr/local/transitclock/Core.jar org.transitclock.applications.GtfsFileProcessor \
  -c "/usr/local/transitclock/config/${AGENCYID}.properties" \
  -storeNewRevs \
  -skipDeleteRevs \
  -gtfsDirectoryName "${DIR}" \
  -supplementDir "${SUPPLEMENT}" 
#  -gtfsUrl "${GTFS_URL}"

psql \
  -h "${POSTGRES_PORT_5432_TCP_ADDR}" \
  -p "${POSTGRES_PORT_5432_TCP_PORT}" \
  -U postgres \
  -d "agency-${AGENCYID}" \
  -c "update activerevisions set configrev=0 where configrev = -1; update activerevisions set traveltimesrev=0 where traveltimesrev = -1;"

echo "THETRANSITCLOCK DOCKER: Finished importing GTFS file for ${AGENCYID}"
