#!/usr/bin/env bash
set -euo pipefail

laws_file="$HOME/.config/lose/laws.json"
laws_url="https://lawsofsoftwareengineering.com/api.json"
laws_dir="$(dirname "$laws_file")"

if ! command -v jq >/dev/null 2>&1; then
  printf 'lose_law: jq is required but not installed\n' >&2
  exit 1
fi

if [[ ! -f "$laws_file" ]]; then
  if ! command -v curl >/dev/null 2>&1; then
    printf 'lose_law: curl is required to download %s\n' "$laws_url" >&2
    exit 1
  fi
  mkdir -p "$laws_dir" || {
    printf 'lose_law: failed to create directory: %s\n' "$laws_dir" >&2
    exit 1
  }
  printf 'lose_law: %s not found, downloading...\n' "$laws_file" >&2
  curl -fsSL "$laws_url" -o "$laws_file" || {
    printf 'lose_law: failed to download laws json from %s\n' "$laws_url" >&2
    rm -f "$laws_file"
    exit 1
  }
fi

count="$(jq -r '.count // (.laws | length)' "$laws_file")"
if [[ ! "$count" =~ ^[0-9]+$ ]] || ((count <= 0)); then
  printf 'lose_law: could not determine law count from %s\n' "$laws_file" >&2
  exit 1
fi

idx=$((RANDOM % count))
jq -r --argjson idx "$idx" '
  .laws[$idx] as $law |
  "\u001b[1mLaw #\($idx)\u001b[0m • \u001b[1;36m\($law.title)\u001b[0m — \u001b[2m\($law.description | gsub("\n"; " "))\u001b[0m"
' "$laws_file"
