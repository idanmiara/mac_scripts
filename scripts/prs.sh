#!/bin/bash
# prs - Project Run Script
# Usage:
#   prs -[fclbiu]   → runs predefined scripts under Poetry
#   prs <command>   → runs arbitrary Poetry command
#
# Examples:
#   prs -fclb       # format, coverage, lint, blackbox (in order)
#   prs python      # poetry run python
#   prs pytest -k test_name

set -e

show_help() {
  echo "Usage:"
  echo "  prs -[options]   Run predefined scripts"
  echo "  prs <command>    Run arbitrary Poetry command"
  echo ""
  echo "Options:"
  echo "  f   Run format or lint fix script (format.sh or fix-lint.sh)"
  echo "  l   Run lint script (lint.sh)"
  echo "  c   Run coverage tests (coverage.sh)"
  echo "  b   Run blackbox tests (blackbox_test.sh)"
  echo "  i   Run image tests (image_test.sh)"
  echo "  u   Run unit tests (unittest.sh)"
  echo "  h   Show help"
  echo ""
  echo "Examples:"
  echo "  prs -flc"
  echo "  prs python"
  echo "  prs pytest tests/"
}

# No args → show help
if [ $# -eq 0 ]; then
  show_help
  exit 0
fi

# If arg starts with '-', parse as flag sequence
if [[ "$1" == -* ]]; then
  FLAGS="${1#-}"

  # Check for help
  if [[ "$FLAGS" == *h* ]]; then
    show_help
    exit 0
  fi

  for FLAG in $(echo "$FLAGS" | grep -o .); do
    case "$FLAG" in
      f)
        if [ -f "./scripts/format.sh" ]; then
          CMD="./scripts/format.sh"
        elif [ -f "./scripts/fix-lint.sh" ]; then
          CMD="./scripts/fix-lint.sh"
        else
          echo "No format or lint-fix script found." >&2
          exit 1
        fi
        echo "→ Running: poetry run sh $CMD"
        poetry run sh "$CMD"
        ;;
      l)
        if [ -f "./scripts/lint.sh" ]; then
          echo "→ Running: poetry run sh ./scripts/lint.sh"
          poetry run sh "./scripts/lint.sh"
        else
          echo "Script not found: ./scripts/lint.sh" >&2
          exit 1
        fi
        ;;
      c)
        echo "→ Running: poetry run sh ./scripts/coverage.sh"
        poetry run sh "./scripts/coverage.sh"
        ;;
      b)
        echo "→ Running: poetry run sh ./scripts/blackbox_test.sh"
        poetry run sh "./scripts/blackbox_test.sh"
        ;;
      i)
        echo "→ Running: poetry run sh ./scripts/image_test.sh"
        poetry run sh "./scripts/image_test.sh"
        ;;
      u)
        echo "→ Running: poetry run sh ./scripts/unittest.sh"
        poetry run sh "./scripts/unittest.sh"
        ;;
      *)
        echo "Unknown flag: -$FLAG" >&2
        show_help
        exit 1
        ;;
    esac
  done
else
  echo "→ Running arbitrary command: poetry run $*"
  poetry run "$@"
fi

