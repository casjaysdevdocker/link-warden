## 👋 Welcome to link-warden 🚀  

link-warden README  
  
  
## Run container

```shell
dockermgr update link-warden
```

### via command line

```shell
docker pull casjaysdevdocker/link-warden:latest && \
docker run -d \
--restart always \
--name casjaysdevdocker-link-warden \
--hostname casjaysdev-link-warden \
-e TZ=${TIMEZONE:-America/New_York} \
-v $HOME/.local/share/docker/storage/link-warden/link-warden/data:/data \
-v $HOME/.local/share/docker/storage/link-warden/link-warden/config:/config \
-p 80:80 \
casjaysdevdocker/link-warden:latest
```

### via docker-compose

```yaml
version: "2"
services:
  link-warden:
    image: casjaysdevdocker/link-warden
    container_name: link-warden
    environment:
      - TZ=America/New_York
      - HOSTNAME=casjaysdev-link-warden
    volumes:
      - $HOME/.local/share/docker/storage/link-warden/data:/data:z
      - $HOME/.local/share/docker/storage/link-warden/config:/config:z
    ports:
      - 80:80
    restart: always
```

## Authors  

🤖 casjay: [Github](https://github.com/casjay) [Docker](https://hub.docker.com/r/casjay) 🤖  
⛵ CasjaysDevdDocker: [Github](https://github.com/casjaysdev) [Docker](https://hub.docker.com/r/casjaysdevdocker) ⛵  
