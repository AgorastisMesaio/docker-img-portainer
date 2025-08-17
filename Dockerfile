# Dockerfile for Portainer
#
# This Dockerfile sets up a standard Portainer container that you can use
# inside your docker compose projects or standalone
#
# Set fixed portainer image
FROM portainer/portainer-ce:2.32.0-alpine

# Update and install curl
RUN apk update && apk add --no-cache curl

# Copy healthcheck
ADD healthcheck.sh /healthcheck.sh
RUN chmod +x /healthcheck.sh

# My custom health check
# I'm calling /healthcheck.sh so my container will report 'healthy' instead of running
# --interval=30s: Docker will run the health check every 'interval'
# --timeout=10s: Wait 'timeout' for the health check to succeed.
# --start-period=3s: Wait time before first check. Gives the container some time to start up.
# --retries=3: Retry check 'retries' times before considering the container as unhealthy.
HEALTHCHECK --interval=30s --timeout=10s --start-period=3s --retries=3 \
  CMD /healthcheck.sh || exit $?

# Default portainer web port
EXPOSE 9000
EXPOSE 9443

# Set default admin password to "super_password".
# Command to get the password: htpasswd -nb -B admin super_password | cut -d ":" -f 2
# Note: I didn't convert $ to $$ on the htpasswd's output
CMD ["--admin-password", "$2y$05$HJStoKdYarBUn/yirrM88.028kKx/rJTfGt7k4Xokh/iA1jzeIWCi"]

