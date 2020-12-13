#!/bin/bash
set -euo pipefail

echo "Enter the keyword for repositories to be deleted:"
read keyword

for k in $(aws codecommit list-repositories | jq -r '.repositories[] | select(.repositoryName | contains("'$keyword'")) | .repositoryName'); do
    output=$(aws codecommit delete-repository --repository-name "$k");
    if [ $? -eq 0 ]; then
        echo ">>> repository deletion SUCCEED: $k"
    fi
done
