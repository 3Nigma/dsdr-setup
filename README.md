# dsdr-setup
or *"Docker Secured Domain Registry Setup" ... the Docker way* is a companion repo to my [Medium article](https://medium.com/@adascalitei.victor/deploying-a-self-hosted-free-public-certified-docker-registry-the-docker-way-3bcc397270ca#.pigqkaakf) treating the same problem.

In a nutshell, it allows for creating of self-hosted and secure docker-registries backed up by [Let's Encrypt!](https://letsencrypt.org/) certificates.

# Prerequisites
A linux operating system with [docker](https://docker.com/) & [docker-compose](https://docs.docker.com/compose/) (**version 2**!) installed along with a registered domain. Before you start, please make sure you have your DNS pointing to the IP of the machine where you want to host the registry otherwise the certificate authority won't issue any certificates.

# Starting it (only linux)
Clone and run ```./go.sh```. You will be required to provide some data before we start the services. Once fired up, it will take some time before registry will be available at the desired address.
