# Data Quality Dashboard (Container)

[OHDSI Data Quality Dashboard](https://github.com/OHDSI/DataQualityDashboard) in a Docker image. Runs data quality checks against an OMOP CDM database.

This repository checks every night for a new version, and publishes the image.

## Use

```bash
docker run --rm --env-file .env -v "$(pwd)/output:/output" ghcr.io/andyrae/dqd-image:latest
```

Results are written to `./output` (JSON, logs, and any error files). The container runs as a non-root user (UID 1000).

## Configure

All behaviour is controlled by environment variables (see `.env.example`):

- **Connection:** `DQD_DBMS`, `DQD_SERVER`, `DQD_PORT`, `DQD_USER`, `DQD_PASSWORD`
- **OMOP:** `DQD_CDM_SCHEMA`, `DQD_RESULTS_SCHEMA`, `DQD_CDM_SOURCE_NAME`, `DQD_CDM_VERSION`
- **Output:** `DQD_OUTPUT_FOLDER` (use `/output` when using the default volume), `DQD_OUTPUT_FILE`
- **Optional:** `DQD_NUM_THREADS`, `DQD_WRITE_TO_TABLE`, `DQD_TABLE_NAME`

The image includes the PostgreSQL JDBC driver. For other databases, mount a folder with the appropriate driver jar(s) at `/jdbc` and see [DatabaseConnector jdbcDrivers](https://ohdsi.github.io/DatabaseConnector/reference/jdbcDrivers.html).
