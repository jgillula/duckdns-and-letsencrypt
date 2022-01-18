# ducksdns-and-letsencrypt

This repo contains a set of scripts to setup [duckdns](https://www.duckdns.org/) and automatically generate [Let's Encrypt](https://letsencrypt.org/) TLS certificates using a lightweight Docker container and DNS challenges without requiring any ports to be exposed.

It builds off of https://github.com/maksimstojkovic/docker-duckdns and https://github.com/maksimstojkovic/docker-letsencrypt, basically setting up those two docker services to run on boot using a systemd service, and then putting the certs in `/etc/letsencrypt/` on the host machine.
