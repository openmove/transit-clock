# OpenMove TransitClock

This is based on Cyberscape transitclock repository:
https://github.com/cscape/interchange

### Running

```sh
. start.sh
```

The start script will build a container, start the PostgreSQL database, create database tables for each transit agency, load the gtfs data into the database, create an API key, and deploy the API + Web service.

The API is available at `http://localhost:3020/api`  
The Web interface is at `http://localhost:3020/web`

## License

[MIT](LICENSE)
