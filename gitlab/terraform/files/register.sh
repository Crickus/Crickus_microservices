#!/bin/bash
set -e

export TOKEN=sxbxqCKxaFN1BJSbRDoz
export MY_IP=http://`curl ifconfig.me`

sudo docker-compose exec gitlab-runner \
    gitlab-runner register \
    --non-interactive \
    --url $MY_IP \
    --registration-token $TOKEN \
    --executor docker \
    --description "my-runner" \
    --docker-image "alpine:latest"

echo "    extra_hosts = [\"gitlab.example.com:`curl ifconfig.me`\"]" >> /srv/gitlab-runner/config/config.toml
echo "    dns = [\"8.8.8.8\"]" >> /srv/gitlab-runner/config/config.toml
