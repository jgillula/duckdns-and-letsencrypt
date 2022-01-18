AC_INIT([duckdns-and-letsencrypt], [1.0.0], [jgillula+duckdns-and-letsencrypt@gmail.com])

dnl----
dnl These are standard Autoconf macros which check for the 
dnl presence of some programs that we will use in the Makefile.
dnl----
dnl
AC_PROG_MKDIR_P
AC_PROG_SED
AC_PROG_INSTALL
AC_PROG_LN_S

AC_PATH_PROG([DOCKER_COMPOSE], [docker-compose])

AS_IF([test -z "$DOCKER_COMPOSE"], AC_MSG_ERROR([docker-compose not found. Please install docker-compose and then re-run configure]))

dnl Define the files to be configured
AC_CONFIG_FILES([Makefile])
dnl Generate the config files
AC_OUTPUT

dnl Print the results to the screen
AC_MSG_NOTICE([NOTE: After installing, edit your configuration at $sysconfdir/duckdns-and-letsencrypt/.env])
AC_MSG_NOTICE([      Your certificates will be available in $sysconfdir/duckdns-and-letsencrypt/certs])
AC_MSG_NOTICE([      Using \${prefix}=$prefix])
