#!/usr/bin/env bash
echo "THETRANSITCLOCK DOCKER: Launching TheTransitClock for ${AGENCYID} using SECONDARY_RMI as ${SECONDARY_RMI}"
. substitute.sh

nohup java \
  -Xss12m \
  -Duser.timezone=CET \
  -Dtransitclock.db.dbName="agency-${AGENCYID}" \
  -Dtransitclock.hibernate.configFile="/usr/local/transitclock/config/hibernate.cfg.xml" \
  -Dtransitclock.db.dbHost="${POSTGRES_PORT_5432_TCP_ADDR}:${POSTGRES_PORT_5432_TCP_PORT}" \
  -Dhibernate.connection.url="jdbc:postgresql://${POSTGRES_PORT_5432_TCP_ADDR}:${POSTGRES_PORT_5432_TCP_PORT}/agency-${AGENCYID}" \
  -Dtransitclock.db.dbUserName="postgres" \
  -Dhibernate.connection.username="postgres" \
  -Dtransitclock.db.dbPassword="${PGPASSWORD}" \
  -Dhibernate.connection.password="${PGPASSWORD}" \
  -Dtransitclock.db.dbType="postgresql" \
  -Dtransitclock.configFiles="/usr/local/transitclock/config/${AGENCYID}.properties" \
  -Dtransitclock.logging.dir="${TRANSITCLOCK_LOGS}" \
  "${SECONDARY_RMI}" \
  -jar /usr/local/transitclock/Core.jar &

echo "THETRANSITCLOCK DOCKER: Launched core for ${AGENCYID} using SECONDARY_RMI as ${SECONDARY_RMI}"

# tail -f /dev/null &
