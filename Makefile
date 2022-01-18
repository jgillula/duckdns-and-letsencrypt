# Makefile.in


# Directories
prefix = 
exec_prefix = ${prefix}
libdir = ${exec_prefix}/lib
srcdir = .
builddir = $(srcdir)/tmp
sysconfdir = ${prefix}/etc
DESTDIR = $(sysconfdir)/duckdns-and-letsencrypt
SYSTEMD_LIBDIR = $(libdir)/systemd/system

# Commands
INSTALL = /usr/bin/install -c
MKDIR_P = /bin/mkdir -p
SED = /bin/sed
DOCKER_COMPOSE = /home/jeremy/.local/bin/docker-compose
LN_S = ln -s

all: build

build: $(builddir) $(builddir)/duckdns-and-letsencrypt.service $(builddir)/.env $(builddir)/docker-compose.yml

$(builddir):
	$(MKDIR_P) $(builddir)

$(builddir)/.env: $(srcdir)/.env
	cp $(srcdir)/.env $(builddir)/.

$(builddir)/docker-compose.yml: $(srcdir)/docker-compose.yml
	cp $(srcdir)/docker-compose.yml $(builddir)/.

$(builddir)/duckdns-and-letsencrypt.service: $(srcdir)/duckdns-and-letsencrypt.service
	cp $(srcdir)/duckdns-and-letsencrypt.service $(builddir)/.
	$(SED) -i -e "s:DOCKER_COMPOSE:$(DOCKER_COMPOSE):g" $(builddir)/duckdns-and-letsencrypt.service

install: build installdirs
	$(INSTALL) -m 664 $(builddir)/duckdns-and-letsencrypt.service $(DESTDIR)
	$(INSTALL) -m 664 $(builddir)/.env $(DESTDIR)
	$(LN_S) -f $(DESTDIR)/duckdns-and-letsencrypt.service $(SYSTEMD_LIBDIR)/.
	systemctl enable duckdns-and-letsencrypt.service

uninstall:
	systemctl disable --now duckdns-and-letsencrypt.service || true
	rm -rf $(DESTDIR)
	rm -f $(SYSTEMD_LIBDIR)/duckdns-and-letsencrypt.service
	find $(libdir) -type d -empty -delete

installdirs: $(DESTDIR) $(SYSTEMD_LIBDIR)

$(DESTDIR):
	$(MKDIR_P) $(DESTDIR)

$(SYSTEMD_LIBDIR):
	$(MKDIR_P) $(SYSTEMD_LIBDIR)

clean:
	rm -rf $(builddir)
