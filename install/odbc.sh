#!/bin/bash

echo "" && echo "-- Installing ODBC SQL Server 17 Driver..."
# https://docs.microsoft.com/en-us/sql/connect/odbc/linux-mac/install-microsoft-odbc-driver-sql-server-macos?view=sql-server-ver15
brew tap microsoft/mssql-release https://github.com/Microsoft/homebrew-mssql-release
brew update
HOMEBREW_NO_ENV_FILTERING=1 ACCEPT_EULA=Y brew install msodbcsql17 mssql-tools
sudo ln -s /usr/local/etc/odbcinst.ini /etc/odbcinst.ini
sudo ln -s /usr/local/etc/odbc.ini /etc/odbc.ini

echo "" && echo "** Some manual symlinking is probably still required:"
# https://github.com/microsoft/homebrew-mssql-release/issues/37
echo "Change to use openssl 1.1 instead of 3"
echo "Folder 1.1.1m might be named differently"
echo "ln -sf /usr/local/Cellar/openssl@1.1/1.1.1m /usr/local/opt/openssl"
