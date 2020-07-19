# Clean up project
sh cleanup.sh

# Getting Fluent Migrator CLI to Run Migrations
dotnet tool install -g FluentMigrator.DotNet.Cli --version 3.2.1

# Getting libman CLI for js package management
dotnet tool install -g Microsoft.Web.LibraryManager.Cli 

# Ignore changes made to the appsettings.Development.json file
git update-index --assume-unchanged Web/appsettings.Development.json

# Moves to web project
cd Web/
# Restore js dependencies
libman restore

# Create SQL Server instance
cd ../
sh docker.sh

# Wait 30 seconds for database to be available
printf "Waiting for database to be ready"
for i in {1..30}
do
    if [ $(( i % 2 )) -eq 0 ];
    then
        sleep 1s
    else
        printf "."
    fi
done
echo

# Restore, build and run Migrations
cd Migrations/
dotnet restore Migrations.csproj
dotnet build Migrations.csproj
dotnet fm migrate -p sqlserver -c "Data Source=localhost,1433;User id=sa;Password=<$YouR_SuPeR_STR0NG_PaSSW0RD!>" -a "bin/Debug/netcoreapp3.1/Migrations.dll"

cd ../
