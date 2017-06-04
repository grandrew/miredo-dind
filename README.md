# miredo-dind
Docker dind with miredo client built-in for pre-configured globally-addressable IPv6 access for exposed ports

## Docker Build Requirements:

- dockerize pre-installed from https://github.com/jwilder/dockerize
- ubuntu with docker installed
- miredo installed and configured on ubuntu where docker is being built

## Usage

Just run the image with `--privileged`. Dind will then have everything exposed via a new teredo IPv6 address and accessible from both Teredo IPv6 and (slower) native IPv6 segments.

You can get the current IP address via `docker exec -it <container_id> ip -6 addr show teredo | grep global | xargs | cut -d' ' -f2 | cut -d'/' -f1`