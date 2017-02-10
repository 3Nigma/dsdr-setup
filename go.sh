#! /bin/bash

echo -----------
echo Docker Secure Domain Registry - Fire up
echo -----------
echo

# Asking for required data
read -p "What will be the domain that will host the registry? [registry.acme.com] : " domain_name
domain_name=${domain_name:-registry.acme.com}

read -p "What username to use when accessing your registry? [admin] : " registry_user
registry_user=${registry_user:-admin}

read -p "What password to use when accessing your registry? [pass] : " registry_pass
registry_pass=${registry_pass:-pass}

while [[ -z "$email_address" ]]
do
  read -p "Please input a valid email address for generating the -Let's Encrypt!- certificates? : " email_address
done

# Docker pre-warmup
echo 'Fetching docker images ...'
docker pull registry:2
docker pull jrcs/letsencrypt-nginx-proxy-companion
docker pull jwilder/nginx-proxy

# Generating the registry password
docker run --entrypoint htpasswd registry:2 -Bbn $registry_user $registry_pass > auth/htpasswd

# Proxy fillings 
echo 'Filling in the nginx vhost.d aditional properties ...'
{ echo 'client_max_body_size 0;'; echo 'chunked_transfer_encoding on;'; } > vhost.d/$domain_name

echo 'Filling in the nginx location aditional properties ...'
{ echo 'proxy_set_header Host $http_host;'; echo 'proxy_set_header X-Real-IP $remote_addr;'; echo 'proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;'; echo 'proxy_set_header X-Forwarded-Proto $scheme;'; echo 'proxy_read_timeout 900;'; } > vhost.d/${domain_name}_location

# Go Docker-compose
echo 'Firing up docker-compose ...'
DOMAIN_NAME=$domain_name;EMAIL_ADDRESS=$email_address; docker-compose up -d
