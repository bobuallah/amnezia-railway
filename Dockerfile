FROM lscr.io/linuxserver/wireguard:latest

# Health check for Railway (dummy OK on port 80)
RUN apk add --no-cache nginx && \
    echo "OK" > /config/www/index.html && \
    sed -i 's|listen 80|listen 80 default_server|' /etc/nginx/conf.d/default.conf

EXPOSE 80/tcp
EXPOSE 51820/udp

# Start nginx + wireguard (auto-gen config)
CMD nginx -g 'daemon off;' && /init
