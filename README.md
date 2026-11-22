# website-orchestrator

## How to run
1. `docker compose --profile all down` -  to stop all service
1. `docker compose --profile all pull` - to pull images
1. `docker compose --profile app build --pull` - to build services, pulling the latest version of the base images when you do that.
1. `docker compose --profile infra up -d` - to bring up infra services
1. `docker compose --profile app up -d` - to bring up app services
