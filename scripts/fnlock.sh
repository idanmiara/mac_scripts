#!/bin/bash
# Toggle or set Fn Lock (Use F1–F12 as standard function keys)
# You can use the Shortcuts app to create a Quick Action ("Run Shell Script")
# Usage:
#   fnlock           → toggle current Fn Lock state
#   fnlock 0         → disable Fn Lock (use special features by default)
#   fnlock 1         → enable Fn Lock (use F1–F12 as standard keys)
#   fnlock -h|--help → show help

set -e

show_help() {
  cat <<EOF
Usage:
  $(basename "$0") [option]

Options:
  0        Disable Fn Lock (use special features by default)
  1        Enable Fn Lock (use F1–F12 as standard keys)
  -h, --help  Show this help message

If no argument is provided, the script toggles the current Fn Lock state.
EOF
}

# Handle help flag
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  show_help
  exit 0
fi

# Read current Fn lock state (0 or 1)
current=$(defaults -currentHost read -g com.apple.keyboard.fnState 2>/dev/null || echo 0)

# Determine new state
if [ -n "$1" ]; then
  if [[ "$1" != "0" && "$1" != "1" ]]; then
    echo "Error: Invalid argument '$1'. Use 0, 1, or -h."
    exit 1
  fi
  new_state="$1"
else
  new_state=$((1 - current))  # toggle
fi

# Apply only if changed
if [ "$new_state" != "$current" ]; then
    if [ "$new_state" = "1" ]; then
        bool_new_state="true"
    else
        bool_new_state="false"
    fi
    defaults -currentHost write -g com.apple.keyboard.fnState -bool "$bool_new_state"
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    message="Fn Lock changed to $new_state"
else
  message="Fn Lock already set to $current (no change)"
fi

echo "$message"

# Try to display a macOS notification
osascript -e 'display notification "'"$message"'" with title "Keyboard Setting"' 2>/dev/null || true
