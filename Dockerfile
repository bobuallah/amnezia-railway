FROM ubuntu:24.04

# Install dependencies (Debian apt)
RUN apt-get update && apt-get install -y \
    curl wget unzip iptables iproute2 wireguard-tools nginx \
    && rm -rf /var/lib/apt/lists/*

# Install Amnezia server (official GitHub script)
RUN curl -fsSL https://raw.githubusercontent.com/amnezia-vpn/amnezia-server/main/install.sh | bash

# Nginx for Railway health check (dummy OK on port 80)
COPY nginx.conf /etc/nginx/sites-available/default
RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default && \
    rm /etc/nginx/sites-enabled/default.bak

# Expose VPN port
EXPOSE 51820/udp
EXPOSE 80/tcp

# Start nginx + Amnezia server
CMD nginx && /usr/local/bin/amnezia-server start
