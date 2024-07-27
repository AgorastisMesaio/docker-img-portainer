# Docker portainer

![GitHub action workflow status](https://github.com/SW-Luis-Palacios/base-portainer/actions/workflows/docker-publish.yml/badge.svg)

This repository contains a `Dockerfile` aimed to create a *base image* to provide a Portainer service that you can use inside your docker compose projects or standalone. Portainer is a lightweight management UI which allows you to easily manage your different Docker environments (Docker hosts or Swarm clusters). Portainer is meant to be as simple to deploy as it is to use..

Typical use cases:

- Setup a Portainer service standalone and use it to manage your containers in your host.
- Include a Portainer service in your docker compose project, so you can manage the containers "inside" the project

## Consume in your `docker-compose.yml`

This is an example of the second use case; I want to have a portainer container inside my docker compose project

```yaml
### Docker Compose example
volumes:
  # Portainer
  pt_portainer_data:
    driver: local

networks:
  my_network:
    name: my_network
    driver: bridge

services:
  ct_portainer:
    image: ghcr.io/sw-luis-palacios/base-portainer:main
    hostname: portainer
    container_name: ct_portainer
    restart: always
    # Change default admin's password to something else, i.e.:
    # htpasswd -nb -B admin super_palabra_clave | cut -d ":" -f 2 | sed 's/\$/\$\$/g'
    # NOTE, in this case I have to change $ to $$
    command: --admin-password '$$2y$$05$$7Yx1.UITGxfCWYxyIDEXq.XXKMjDQjjYIrT7TAVrB2Fow9BsVlhpe'
    ports:
      - "9000:9000"
      #- "9443:9443" # For https
    networks:
      - my_network
    volumes:
      # Access to docker's internals
      - /var/run/docker.sock:/var/run/docker.sock
      - pt_portainer_data:/data

  ct_other_container:
    :

  ct_other_container:
    :

  ct_other_container:
    :
```

- Start your services

```sh
docker compose up --build -d
```

- Connect to your portainer at [http://127.0.0.1:9000](http://127.0.0.1:9000)

## For developers

If you copy or fork this project to create your own base image.

### Building the Image

To build the Docker image, run the following command in the directory containing the Dockerfile:

```sh
docker build -t your-image/base-portainer:main .
```

### Troubleshoot

```sh
docker run --rm --name ct_portainer --hostname portainer -p 9000:9000 your-image/base-portainer:main
```
