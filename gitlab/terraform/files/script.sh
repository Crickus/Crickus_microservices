#!/bin/bash
set -e

# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# sudo add-apt-repository "deb https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
# sudo apt-get update
# sudo apt-get install docker-ce docker-compose docker-ce-cli containerd.io python-docker -y

# export MY_IP=http://$(curl ifconfig.me)
# MY_IP=http://$(curl ifconfig.me)
# echo 'export MY_IP=http://$(curl ifconfig.me)' >> ~/.bashrc
# source ~/.bashrc

sudo mkdir -p /srv/gitlab/config /srv/gitlab/data /srv/gitlab/logs
cd /srv/gitlab/

sudo mv /tmp/docker-compose.yml /srv/gitlab/docker-compose.yml
sudo mv /tmp/.env /srv/gitlab/.env
sudo docker-compose up -d
# sudo docker-compose exec gitlab-runner \
#     gitlab-runner register \
#     --non-interactive \
#     --url $MY_IP \
#     --registration-token <YOUR-GITLAB-REGISTRATION-TOKEN> \
#     --executor docker \
#     --description "my-runner" \
#     --docker-image "alpine:latest"

