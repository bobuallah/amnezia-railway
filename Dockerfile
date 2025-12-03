FROM lscr.io/linuxserver/wireguard:latest

# Install AmneziaWG tools (obfuscated WireGuard)
RUN apk add --no-cache curl bash && \
    curl -L https://github.com/amnezia-vpn/amneziawg-tools/releases/latest/download/amneziawg-server-linux-x64 -o /usr/bin/awg && \
    chmod +x /usr/bin/awg

EXPOSE 51820/udp

CMD ["awg", "--server"]
# Dummy HTTP server for Railway health check
RUN apk add --no-cache nginx
COPY nginx.conf /etc/nginx/nginx.conf
CMD ["sh", "-c", "nginx & awg --server"]
