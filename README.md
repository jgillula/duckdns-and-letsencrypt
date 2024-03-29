# ducksdns-and-letsencrypt

This repo contains a set of scripts to setup [duckdns](https://www.duckdns.org/) and automatically generate [Let's Encrypt](https://letsencrypt.org/) TLS certificates using a lightweight Docker container and DNS challenges without requiring any ports to be exposed.

It builds off of https://github.com/maksimstojkovic/docker-duckdns and https://github.com/maksimstojkovic/docker-letsencrypt, basically setting up those two docker services to run on boot using a systemd service, and then putting the certs in `/usr/local/etc/duckdns-and-letsencrypt/certs` on the host machine.

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
UID=0
GID=0
```
Note: if you want the user/group for the certificates to be something besides root, you can change the UID and GID here. For example, you might want to create a group called `duckdnsandletsencrypt` with
```
sudo addgroup --system duckdnsandletsencrypt
echo "GID=$( getent group duckdnsandletsencrypt | cut -d: -f3 )"
```

Finally, start the service with
```
sudo systemctl start duckdns-and-letsencrypt.service
```
The first time you start the service it may take a while, since it has to pull down the docker images. Once it's running, your certificates should be available at `/usr/local/etc/duckdns-and-letsencrypt/certs/live/something.duckdns.org/`

Note: Let's Encrypt [makes the directories where the certificates are stored unreadable by group by default](https://eff-certbot.readthedocs.io/en/stable/using.html#where-are-my-certificates), so if you want the certificates to be readable by users in the `duckdnsandletsencrypt` group, wait until after the first certs are generated and then do:
```
sudo chmod g+rx /usr/local/etc/duckdns-and-letsencrypt/certs/{live,archive}
sudo chmod g+r /usr/local/etc/duckdns-and-letsencrypt/certs/archive/$domain/privkey.pem
```
