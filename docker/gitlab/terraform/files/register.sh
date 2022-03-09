#!/bin/bash
set -e

export TOKEN=sxbxqCKxaFN1BJSbRDoz
export MY_IP=http://`curl ifconfig.me`
export MY_IP_bold=`curl ifconfig.me`

sudo docker-compose exec gitlab-runner \
    gitlab-runner register \
    --non-interactive \
    --docker-privileged \
    --url $MY_IP \
    --registration-token $TOKEN \
    --executor docker \
    --description "my-runner" \
    --docker-image "docker:stable" \
    --extra_hosts ["gitlab.example.com:$MY_IP_bold"] \
    --dns ["8.8.8.8"] \
    --volumes ["/var/run/docker.sock:/var/run/docker.sock", "/cache"]

# echo "    extra_hosts = [\"gitlab.example.com:`curl ifconfig.me`\"]" >> /srv/gitlab-runner/config/config.toml
# echo "    dns = [\"8.8.8.8\"]" >> /srv/gitlab-runner/config/config.toml
# echo "    volumes = [\"/var/run/docker.sock:/var/run/docker.sock\", \"/cache\"]"
