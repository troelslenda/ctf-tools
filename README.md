# Kali CTF container

A disposable Kali Linux environment for CTF challenges, with the working directory and shell history kept on the host. It uses Podman and Compose, so no Kali packages need to be installed on Fedora.

Use these tools only against CTF infrastructure and systems you are authorized to test.

## Requirements

- Fedora with rootless [Podman](https://podman.io/) installed
- `podman-compose`

Verify the setup:

```bash
podman --version
podman-compose --version
```

## Start

```bash
./start.sh
```

The script builds the image when needed, recreates the `kali-ctf` container, and opens a Bash shell inside it. The first build is intentionally large because `kali-linux-headless` includes a broad set of Kali tooling.

Leave the container shell with `exit`. The container remains running and can be opened again with `./start.sh`.

## Files and persistence

| Host path | Container path | Purpose |
| --- | --- | --- |
| `./workspace/` | `/root/ctf` | Challenge files, scripts, notes, and outputs |
| `./.bash_history` | `/root/.bash_history` | Persistent shell history |

Keep every challenge artifact in `workspace/`; it survives container recreation and is available normally from Fedora.

## Included tools

The image includes Kali's `kali-linux-headless` metapackage plus some commonly useful command-line extras:

- Web and enumeration: `ffuf`, `gobuster`, `nmap`, `seclists`, `smbclient`, `ldapsearch`
- Pwn and reversing: `gdb`, `gdb-multiarch`, `pwntools` (`pwn`), `checksec`, `radare2` (`r2`), `strace`, `ltrace`
- Forensics and stego: `binwalk`, `exiftool`, `foremost`, `pngcheck`, `steghide`, `zsteg`
- Passwords and crypto: `john`, `hashcat`
- Network and PCAPs: `tshark`, `tcpdump`, `socat`, `netcat`
- Quality-of-life: `tmux`, `neovim`, `ripgrep`, `jq`, `p7zip`

The container intentionally excludes heavyweight desktop applications such as Burp Suite, Ghidra, and graphical Wireshark. Run those on the Fedora host if you need them.

## Useful commands

Open another shell without rebuilding:

```bash
podman-compose exec kali-ctf /bin/bash
```

See service state:

```bash
podman-compose ps
```

View the container logs:

```bash
podman-compose logs -f kali-ctf
```

Stop it when you are finished:

```bash
podman-compose down
```

Rebuild after editing the Dockerfile:

```bash
podman-compose build
./start.sh
```

## Networking

The service uses `network_mode: host`. From inside the container, `localhost` is your Fedora host and the container shares the host network stack. That is convenient for local challenge services, but only connect to CTF targets you are authorized to access.

## Troubleshooting

If Podman has stale state or the image fails to start, recreate the service:

```bash
podman-compose down
./start.sh
```

If a package fails during a later rebuild, Kali Rolling has likely renamed or removed it. Run the build again to see the exact package error, then update the package list in `Dockerfile`.
