#!/usr/bin/env bash

set -euo pipefail

usage() {
    cat <<EOF
Usage: $0 [options] <ticket-id>

Retrieve information about a Jira work item.

Arguments:
  <ticket-id>   Jira ticket key (e.g. PROD-1234)

Options:
  --json        Output raw JSON instead of human-readable format
  --help        Show this help message
EOF
}

ticket=""
json_flag=false

while [[ $# -gt 0 ]]; do
    case "$1" in
    --json)
        json_flag=true
        ;;
    --help)
        usage
        exit 0
        ;;
    -*)
        echo "Unknown option: $1"
        echo
        usage
        exit 1
        ;;
    *)
        ticket=$(echo "$1" | tr '[:lower:]' '[:upper:]')
        ;;
    esac
    shift
done

[[ -z "${ticket}" ]] && {
    usage
    exit 1
}

[[ ! "${ticket}" =~ ^[A-Z]+-[0-9]+$ ]] && {
    echo "Invalid ticket format: ${ticket} (expected e.g. PROD-1234)"
    exit 1
}

if [[ ${json_flag} == 'true' ]]; then
    acli jira workitem view "${ticket}" --json
else
    acli jira workitem view "${ticket}"
fi
