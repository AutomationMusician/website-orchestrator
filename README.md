# website-orchestrator

## How to run containers
1. `docker compose --profile all down` -  to stop all service
1. `docker compose --profile all pull` - to pull images
1. `docker compose --profile app build --pull` - to build services, pulling the latest version of the base images when you do that.
1. `docker compose --profile infra up -d` - to bring up infra services
1. `docker compose --profile app up -d` - to bring up app services

## How to setup the Raspberry Pi

### Re-Imaging

Re-image using the Raspberry Pi Imager. Use the settings you have used in the past and are saved as defaults. The main notable settings are:
- Use the "Raspberry Pi OS Lite (64-bit)" Image
- Use the rpi5 ssh key

### Post-startup Configuration

Once ssh access is obtained, SCP the files in the "setup" directory and chmod +x the scripts.

Then, ssh into the Pi and run `sudo su` to escalate to the root user. Run root-setup.sh to run the setup steps requiring root access.

Next, exit out of the root shell back into the user shell and run the user-setup.sh script, which configures things not requiring root access.

Finally, run the manual setup steps:

### Manual setup

1. Tailscale:
    1. Authenticate tailscale: tailscale up
    1. Allow ssh and exit node via the admin console: https://console.tailscale.com/admin/machines. Also disable key expiry.
1. Setup wifi router to allow traffic from http/https ports directly to this IP
1. In the cloned website-orchestrator directory, setup your `.env` file with the appropriate values following `example.env` in this repository.
1. Run the containers as described in "How to run containers" section

