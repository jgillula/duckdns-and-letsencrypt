# ducksdns-and-letsencrypt

This repo contains a set of scripts to setup [duckdns](https://www.duckdns.org/) and automatically generate [Let's Encrypt](https://letsencrypt.org/) TLS certificates using a lightweight Docker container and DNS challenges without requiring any ports to be exposed.

It builds off of https://github.com/maksimstojkovic/docker-duckdns and https://github.com/maksimstojkovic/docker-letsencrypt, basically setting up those two docker services to run on boot using a systemd service, and then putting the certs in `/usr/local/etc/duckdns-and-letsencrypt/` on the host machine.

## To use:

First, get the repo and install it
```
git clone https://github.com/jgillula/duckdns-and-letsencrypt.git
cd duckdns-and-letsencrypt
./configure #Use --prefix=/ if you want things in /etc and /lib instead of /usr/local/etc and /usr/local/lib
make
sudo make install
```

Then, get your token and hostname from [https://www.duckdns.org/](https://www.duckdns.org/), and put them in the file `/usr/local/etc/duckdns-and-letsencrypt/.env`. When you're done, it should look something like:
```
DUCKDNS_TOKEN=BLAH-ABC1234-ETC
DUCKDNS_DOMAIN=something.duckdns.org
```

Finally, start the service with
```
sudo systemctl start duckdns-and-letsencrypt.service
```

