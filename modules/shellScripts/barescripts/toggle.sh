set -euo pipefail

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <service-name>"
    exit 1
fi

SERVICE="$1"

if systemctl is-active --quiet "$SERVICE"; then
    echo "Stopping $SERVICE..."
    systemctl stop "$SERVICE"
else
    echo "Starting $SERVICE..."
    systemctl start "$SERVICE"
fi