# PSDotEnv

Powershell module that load, unload variables from dotenv files (manually)

## Installation

```powershell
Install-Module PSDotEnv
```

Import me in `$PROFILE`

```ps1
Import-Module PSDotEnv

# Your other cool stuffs
# ...
```


## Usage

Load variables from `.env` file (default)

```powershell
> cd project
> Set-DotEnv -Verbose
VERBOSE: Checking .env exists
VERBOSE: Getting variables
VERBOSE: Setting foo
```

Load from a specific dotenv file

```powershell
> cd project
> Set-DotEnv -Path .\.env.prod -Verbose
VERBOSE: Checking .env.prod exists
VERBOSE: Getting variables
VERBOSE: Setting foo
```

Unload dotenv
```powershell
> cd project
> Redo-DotEnv -Path .\.env.prod -Verbose
VERBOSE: Checking .env.prod exists
VERBOSE: Getting variables
VERBOSE: Unsetting foo
```

