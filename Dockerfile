FROM kalilinux/kali-rolling

ENV DEBIAN_FRONTEND=noninteractive

RUN touch /root/.bash_history


RUN apt-get update && apt-get install -y \
  kali-linux-headless \
  python3 python3-pip \
  git curl wget unzip \
  net-tools iputils-ping dnsutils \
  gdb build-essential \
  binwalk exiftool steghide \
  gobuster ffuf \
  nmap netcat-traditional socat \
  sqlite3 jq \
  curl wget git unzip iputils-ping net-tools dnsutils \
  #&& pip3 install pwntools \
  python3-pwntools \
  tmux neovim \
  htop \
  && apt-get clean

WORKDIR /root/ctf

CMD ["/bin/bash"]
