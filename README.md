# ⭕ Zen Browser
This container allows you to access the [zen browser][zen] trough another web browser using [kasmvnc][kasm]. Zen is a fork of firefox, with a new design, more customizability, and more privacy features.

## Setup

> [!WARNING]  
> Zen is still in **beta**! If you experience bugs or other issues, make sure to [report][rep] them to the zen team!

To set up the container, you can either use docker-compose or the docker cli. You can also use options and additional settings/mods from linuxserver.io.
And to update the container, simply pull the latest image, and redeploy it.

### [docker-compose][dcompose] (recommended)

```yaml
---
services:
  zen:
    image: ghcr.io/tibor309/zen:latest
    container_name: zen-browser
    security_opt:
      - seccomp:unconfined #optional
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Etc/UTC
      - ZEN_CLI=https://www.github.com/ #optional
    volumes:
      - /path/to/config:/config
    ports:
      - 3000:3000
      - 3001:3001
    shm_size: "1gb"
    restart: unless-stopped
```

### [docker-cli][dcli]

```bash
docker run -d \
  --name=zen-browser \
  --security-opt seccomp=unconfined `#optional` \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Etc/UTC \
  -e ZEN_CLI=https://www.github.com/ `#optional` \
  -p 3000:3000 \
  -p 3001:3001 \
  -v /path/to/config:/config \
  --shm-size="1gb" \
  --restart unless-stopped \
  ghcr.io/tibor309/zen:latest
```

## Config

Since zen is based on firefox, you can use additional parameters and settings from the [linuxserver/docker-firefox][firefox-setup] project!

| Parameter | Function |
| :----: | --- |
| `-p 3000` | Zen desktop gui. |
| `-p 3001` | HTTPS Zen desktop gui. |
| `-e PUID=1000` | For UserID |
| `-e PGID=1000` | For GroupID |
| `-e TZ=Etc/UTC` | Specify a timezone to use, see this [list][tz]. |
| `-e ZEN_CLI=https://www.github.com/` | Specify one or multiple [Zen CLI flags][flags], this string will be passed to the application in full. |
| `-v /config` | Users home directory in the container, stores local files and settings |
| `--shm-size=` | This is needed for any modern website to function like youtube. |
| `--security-opt seccomp=unconfined` | For Docker Engine only, many modern gui apps need this to function on older hosts as syscalls are unknown to Docker. |

## Usage
To access the container, navigate to the ip address for your machine with the port you provided at the setup.

* [http://yourhost:3000/][link]
* [https://yourhost:3001/][link]


[zen]: https://zen-browser.app/
[kasm]: https://kasmweb.com/kasmvnc
[firefox-setup]: https://github.com/linuxserver/docker-firefox/blob/master/README.md#application-setup
[rep]: https://github.com/zen-browser/desktop/issues

[dcompose]: https://docs.linuxserver.io/general/docker-compose
[dcli]: https://docs.docker.com/engine/reference/commandline/cli/
[flags]: https://wiki.mozilla.org/Firefox/CommandLineOptions
[tz]: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones#List
[link]: https://www.youtube.com/watch?v=dQw4w9WgXcQ
