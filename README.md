# Home Assistent Matter Server Docker Image
Docker image for Home Assistant [python-matter-server](https://github.com/home-assistant-libs/python-matter-server)

## Docker run example
```sh
docker run -d \
  --name matter-server \
  --restart always \
  --network=host \
  --security-opt apparmor:unconfined \
  -e TZ=Europe/Bucharest \
  -v path/to/data:/data \
  -v /run/dbus:/run/dbus:ro \
  ghcr.io/rursache/hass-matter-server-docker:latest
```
