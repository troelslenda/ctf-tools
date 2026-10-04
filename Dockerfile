FROM kalilinux/kali-rolling

ENV DEBIAN_FRONTEND=noninteractive

RUN touch /root/.bash_history

RUN apt-get update && apt-get install -y --no-install-recommends \
    kali-linux-headless \
    binwalk build-essential checksec curl dnsutils exiftool ffuf file foremost \
    gdb gdb-multiarch git gobuster hashcat htop iputils-ping john jq \
    ldap-utils libc6-dbg ltrace net-tools netcat-traditional neovim nmap \
    p7zip-full pngcheck python3 python3-pip python3-pwntools python3-venv \
    radare2 ripgrep ruby seclists smbclient socat sqlite3 steghide strace tcpdump \
    tmux tshark unzip wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && gem install --no-document zsteg -v 0.2.14

WORKDIR /root/ctf

CMD ["/bin/bash"]
