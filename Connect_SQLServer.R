#########################################################
############################################################################
####### This script connects your R to your SQL Server database.  ##

if (!require("RJDBC")) install.packages('RJDBC',repos = "http://cran.us.r-project.org")
if (!require("httr")) install.packages('httr',repos = "http://cran.us.r-project.org")

library(httr)
library(RJDBC)


# Get passed environment variables.
env_var_names <- list("ACHILLES_SOURCE", "ACHILLES_DB_URI",
                      "ACHILLES_CDM_SCHEMA", "ACHILLES_VOCAB_SCHEMA",
                      "ACHILLES_RES_SCHEMA", "ACHILLES_OUTPUT_BASE",
                      "ACHILLES_CDM_VERSION")
env_vars <- Sys.getenv(env_var_names, unset=NA)

# Replace unset environement variables with defaults.
default_vars <- list("N/A", "postgresql://localhost/postgres",
                     "public", "public", "public", "./output", "5")
env_vars[is.na(env_vars)] <- default_vars[is.na(env_vars)]

# Parse DB URI into pieces.
db_conf <- parse_url(env_vars$ACHILLES_DB_URI)

# set up connection
path01 <- getwd()
drv <- JDBC("com.microsoft.sqlserver.jdbc.SQLServerDriver", paste0(path01,"/DBMS Connections/sqljdbc4.jar"),
            identifier.quote="`")
# creating a connection object by calling dbConnect
url = paste0("jdbc:sqlserver://",db_conf$hostname,";databaseName=",db_conf$scheme)
conn <- dbConnect(drv, 
                  url, 
                  db_conf$username, 
                  db_conf$password)

#######
######## If you don't know your data base name and address, contact your server admin.
#######