#!/usr/bin/env bash

set -euo pipefail

pr_number=$(gh pr view --json number --jq '.number')
owner=$(gh repo view --json owner --jq '.owner.login')
repo=$(gh repo view --json name --jq '.name')

gh api graphql -f query="
{
  repository(owner: \"${owner}\", name: \"${repo}\") {
    pullRequest(number: ${pr_number}) {
      reviewThreads(first: 100) {
        nodes {
          id
          isResolved
          isOutdated
          comments(first: 100) {
            nodes {
              author { login }
              body
              path
              line
              url
            }
          }
        }
      }
    }
  }
}" | jq -r '
  .data.repository.pullRequest.reviewThreads.nodes[]
  | select(.isResolved == false)
  | (.comments.nodes | length) as $total
  | .comments.nodes[0] as $c
  | "[\(.id)]\(if .isOutdated then " [outdated]" else "" end)\(if $total > 1 then " [\($total) comments]" else "" end)\n\($c.author.login)  \($c.path)\(if $c.line then ":\($c.line)" else "" end)\n\($c.body)\n\($c.url)\n"
'
