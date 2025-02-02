# website-orchestrator

## How to run
1. `docker compose --profile all down` -  to stop all service
1. `docker compose --profile app build` - to build services
1. `docker compose --profile infra up -d` - to bring up infra services
1. `docker compose --profile app up -d` - to bring up app services
