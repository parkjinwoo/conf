Podman
======

## Install

```sh
# Podman 컨테이너 도구
# podman: Docker 대체 컨테이너 엔진 (데몬리스, 루트리스)
# podman-compose: docker-compose 대체
# lazydocker: 컨테이너 관리 TUI
brew install \
  podman \
  podman-compose \
  lazydocker
```

## podman machine

```sh
# 1) machine 초기화 (아래 중 택1)
podman machine init
podman machine init --cpus=4 --memory=4096 --disk-size=100
podman machine init -v "$HOME:$HOME"
podman machine init -v "$HOME:$HOME:z"

# 2) 시작
podman machine start

# 기타 설정/운영
podman machine set --rootful
podman machine ssh sudo sysctl -w net.ipv4.ip_unprivileged_port_start=0
podman run -it --rm --cap-add net_bind_service my/image
```

## Apple Silicon: amd64 이미지 실행이 필요한 경우

```sh
podman machine ssh sudo rpm-ostree install qemu-user-static
podman machine ssh sudo systemctl reboot
```

## Useful commands

```sh
podman machine info
podman machine ls
podman machine rm
podman machine ssh
podman system prune
podman run -it ubuntu bash
podman ps
podman images
podman login registry.example.com
```

## Docker 호환 사용

```sh
# Linux: Podman 소켓 활성화
systemctl --user start podman.socket

# macOS: podman machine 시작 시 소켓 자동 활성화
# 경로는 환경마다 다를 수 있으므로 inspect로 확인
podman machine inspect --format '{{.ConnectionInfo.PodmanSocket.Path}}'

# .zshrc 예시
export DOCKER_HOST="unix://$HOME/.local/share/containers/podman/machine/podman.sock"
alias docker=podman
```

## Buildx-style multi-arch build

```sh
podman build --platform linux/arm64,linux/amd64 --format docker -t my-image .
```

## podman compose

```sh
podman-compose up -d
```

```yaml
# 컨테이너 -> 호스트 접근 예시
services:
  web:
    image: nginx
    extra_hosts:
      - "host.docker.internal:host-gateway"  # Docker 호환
```

```sh
# 컨테이너 내부에서
curl http://host.containers.internal:8080
```
