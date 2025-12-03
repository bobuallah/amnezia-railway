FROM ubuntu:24.04

# Install everything
RUN apt-get update && apt-get install -y \
    curl wget unzip iptables iproute2 wireguard-tools nginx \
    && rm -rf /var/lib/apt/lists/*

# Install Amnezia server (correct branch = master)
RUN curl -fsSL https://raw.githubusercontent.com/amnezia-vpn/amnezia-server/master/install.sh | bash

# Dummy health check for Railway
RUN echo 'OK' > /var/www/html/index.html
RUN sed -i 's|/var/www/html|/var/www/html/index.html|' /etc/nginx/sites-available/default

EXPOSE 80/tcp
EXPOSE 51820/udp

# Start both nginx and Amnezia server
CMD nginx && /usr/local/bin/amnezia-server start || tail -f /dev/null
