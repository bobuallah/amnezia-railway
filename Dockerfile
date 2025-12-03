FROM lscr.io/linuxserver/wireguard:latest

# Install AmneziaWG tools (obfuscated WireGuard)
RUN apk add --no-cache curl bash && \
    curl -L https://github.com/amnezia-vpn/amneziawg-tools/releases/latest/download/amneziawg-server-linux-x64 -o /usr/bin/awg && \
    chmod +x /usr/bin/awg

EXPOSE 51820/udp

CMD ["awg", "--server"]
