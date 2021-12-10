# Migro

This shell app migrate/update a repository data from origin git server to a destiny git server

### How it works? :gear:
- Excecute the shell script providing origin and destiny respositories
- Monitoring output (this script still is beta)
- Got migrated repository

## Usage :video_game:

:warning: you must use Linux or [WSL on windows](https://docs.microsoft.com/pt-br/windows/wsl/install-win10).

In your terminal, execute:

- `git clone git@github.com:vortx-dtvm/Migro.git && cd Migro`
- `sh migrate.sh <origin> <destiny>`

After migrated the repository, download the new repository or update your git remote in your local machine:

- `git remote set-url origin <new-repository>`

### Example :eyes:

- `sh migrate.sh git@ssh.dev.azure.com:v3/orgName/RepoName/migro.API git@github.com:orgname/Migro.API.git`
- `cd Migro`
- `git remote set-url origin git@github.com:orgname/Migro.API.git`

teste

