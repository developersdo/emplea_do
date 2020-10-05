# Create a new container for SQL Server and volume
docker run `
    -e ACCEPT_EULA=Y `
    -e MSSQL_PID="Developer" `
    -e SA_PASSWORD="<$YouR_SuPeR_STR0NG_PaSSW0RD!>" `
    -p 1433:1433 `
    -v empleado-db-volume:/var/opt/mssql `
    --name empleado-db `
    -d microsoft/mssql-server-linux