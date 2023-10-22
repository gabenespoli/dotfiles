#!/bin/bash

echo "" && echo "-- Installing Microsoft ODBC..."
# https://docs.microsoft.com/en-us/sql/connect/odbc/linux-mac/install-microsoft-odbc-driver-sql-server-macos?view=sql-server-ver15
brew tap microsoft/mssql-release https://github.com/Microsoft/homebrew-mssql-release
brew update
HOMEBREW_ACCEPT_EULA=Y brew install msodbcsql18 mssql-tools18

# Message from homebrew after installing:
#
# If you installed this formula with the registration option (default), you'll
# need to manually remove [ODBC Driver 18 for SQL Server] section from
# odbcinst.ini after the formula is uninstalled. This can be done by executing
# the following command:
#     odbcinst -u -d -n "ODBC Driver 18 for SQL Server"
#


# brew tap microsoft/mssql-release https://github.com/Microsoft/homebrew-mssql-release
# brew update
# HOMEBREW_NO_ENV_FILTERING=1 ACCEPT_EULA=Y brew install msodbcsql17 mssql-tools
# sudo ln -s /usr/local/etc/odbcinst.ini /etc/odbcinst.ini
# sudo ln -s /usr/local/etc/odbc.ini /etc/odbc.ini

# echo "" && echo "** Some manual symlinking is probably still required:"
# # https://github.com/microsoft/homebrew-mssql-release/issues/37
# echo "Change to use openssl 1.1 instead of 3"
# echo "Folder 1.1.1m might be named differently"
# echo "ln -sf /usr/local/Cellar/openssl@1.1/1.1.1m /usr/local/opt/openssl"


# export UNIXODBC_VERSION="odbcinst -j | grep 'unixODBC ' | sed -e 's/unixODBC //'"
# export LDFLAGS="-L/opt/homebrew/Cellar/unixodbc/$UNIXODBC_VERSION/lib"
# export CPPFLAGS="-I/opt/homebrew/Cellar/unixodbc/$UNIXODBC_VERSION/include"

# export LDFLAGS="-L/opt/homebrew/Cellar/unixodbc/2.3.12/lib"
# export CPPFLAGS="-I/opt/homebrew/Cellar/unixodbc/2.3.12/include"

