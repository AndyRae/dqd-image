connectionDetails <- DatabaseConnector::createConnectionDetails(
  dbms = Sys.getenv("DQD_DBMS"),
  user = Sys.getenv("DQD_USER"),
  password = Sys.getenv("DQD_PASSWORD"),
  server = Sys.getenv("DQD_SERVER"),
  port = Sys.getenv("DQD_PORT"),
  pathToDriver = "/jdbc"
)

DataQualityDashboard::executeDqChecks(
  connectionDetails = connectionDetails,
  cdmDatabaseSchema = Sys.getenv("DQD_CDM_SCHEMA"),
  resultsDatabaseSchema = Sys.getenv("DQD_RESULTS_SCHEMA"),
  cdmSourceName = Sys.getenv("DQD_CDM_SOURCE_NAME"),
  cdmVersion = Sys.getenv("DQD_CDM_VERSION"),
  numThreads = as.integer(Sys.getenv("DQD_NUM_THREADS", "1")),
  sqlOnly = FALSE,
  outputFolder = Sys.getenv("DQD_OUTPUT_FOLDER"),
  outputFile = Sys.getenv("DQD_OUTPUT_FILE"),
  verboseMode = TRUE,
  writeToTable = as.logical(Sys.getenv("DQD_WRITE_TO_TABLE", "TRUE")),
  writeTableName = Sys.getenv("DQD_TABLE_NAME"),
  checkLevels = c("TABLE", "FIELD", "CONCEPT"),
  checkSeverity = c("fatal", "convention", "characterization"),
  tablesToExclude = c("CONCEPT", "VOCABULARY", "CONCEPT_ANCESTOR",
                      "CONCEPT_RELATIONSHIP", "CONCEPT_CLASS",
                      "CONCEPT_SYNONYM", "RELATIONSHIP", "DOMAIN")
)
