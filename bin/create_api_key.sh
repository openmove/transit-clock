#!/usr/bin/env bash
echo "THETRANSITCLOCK DOCKER: Create API key for ${AGENCYID}"
set -u
. substitute.sh

# ONLY CREATE THIS API KEY
# FOR THE PRIMARY CORE

java \
  -cp /usr/local/transitclock/Core.jar org.transitclock.applications.CreateAPIKey \
  -c "\"/usr/local/transitclock/config/${AGENCYID}.properties\"" \
  -n "Federico Bertolini" \
  -u "http://www.openmove.com" \
  -e "developers@openmove.com" \
  -p "0464790009" \
  -d "developer"

echo "THETRANSITCLOCK DOCKER: Finished creating API key for ${AGENCYID}"
