# Dockerfile for Portainer
#
# This Dockerfile sets up a standard Portainer container that you can use
# inside your docker compose projects or standalone
#

# Set fixed portainer image
#FROM portainer/portainer-ce:latest
FROM portainer/portainer-ce:2.20.3

# Set default admin password to "super_password".
# Command to get the password: htpasswd -nb -B admin super_password | cut -d ":" -f 2
# Note: I didn't convert $ to $$ on the htpasswd's output
CMD ["--admin-password", "$2y$05$HJStoKdYarBUn/yirrM88.028kKx/rJTfGt7k4Xokh/iA1jzeIWCi"]

# Default portainer web port
EXPOSE 9000
EXPOSE 9443
