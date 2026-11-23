
#!/usr/bin/env bash

set -euo pipefail

echo "=== Cloning repositories ==="
REPO_DIR="$HOME/repos"

mkdir -p "$REPO_DIR"
cd "$REPO_DIR"

REPOS=(
    "https://github.com/AutomationMusician/website-orchestrator.git"
    "https://github.com/AutomationMusician/super-bowl-quiz.git"
    "https://github.com/AutomationMusician/personal-site.git"
    "https://github.com/AutomationMusician/connect-4-ai-801.git"
)

for repo in "${REPOS[@]}"; do
    repo_name=$(basename "$repo" .git)

    if [ -d "$repo_name" ]; then
        echo "Skipping $repo_name (already exists)"
    else
        git clone "$repo"
    fi
done

echo "=== Setting up DuckDNS Update Script Cron ==="

CRON_JOB="15 * * * * /home/jfishman/repos/website-orchestrator/duckdns-update.sh"

# Check if the job already exists (ignoring errors if crontab is currently empty)
if ! crontab -l 2>/dev/null | grep -Fq "$CRON_JOB"; then
    (crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -
    echo "Cron job added."
else
    echo "Cron job already exists."
fi


echo "=== Setting up rpi-connect ==="

rpi-connect on
loginctl enable-linger

echo "=== Setup complete! ==="
