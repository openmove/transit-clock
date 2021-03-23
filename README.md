# OpenMove TransitClock

This is based on Cyberscape TransitClock automated [installer](https://github.com/cscape/interchange).

For further information see [TheTransitClock](https://github.com/TheTransitClock/transitime) repository.

### Running

```sh
./start.sh
```

The start script will:

- build a container, 
- start the PostgreSQL database, 
- create database tables for each transit agency, 
- load the gtfs data into the database, 
- create an API key, 
- and deploy the API service.

The API is available at `http://localhost:3020/api`  

### Example

```
curl -X POST "http://localhost:3020/api/v1/key/{generated-key}/agency/TT/command/pushAvl" \
-H "Content-Type: application/json" \ 
-d '{avl: [{v: "vehicleId1", 
            t: epochTimeMsec, 
            lat: 46.07153531617033, 
            lon: 11.127740289079219,
            s: 20, 
            h: 90, 
            assignmentId: 4321, 
            assignmentType: TRIP_ID
           }
          ]}'
```
- speed, heading, assignmentId and assignmentType are optional.
- assignmentType can be BLOCK_ID, ROUTE_ID, TRIP_ID, or TRIP_SHORT_NAME.

Then you can retrieve GTFS-RT tripUpdates generated with:

```
curl http://localhost:3020/api/v1/key/{generated-key}/agency/TT/command/gtfs-rt/tripUpdates?format=human
```

For further information go to [TransitClock Wiki](https://github.com/Transitime/core/wiki/API)

## License

[MIT](LICENSE)
