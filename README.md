# linux-loogarch

[![Docker Hub](https://github.com/githubclaire/linux-dbg-arm/actions/workflows/ci-docker.yml/badge.svg)](https://hub.docker.com/r/dockerhy/linux-dbg-arm)

## Build up the docker image locally

```
docker build --pull --rm -f "Dockerfile" -t ${LABEL}:latest "."
```

`${LABEL}` could any string.

## How to use this tool chain

1. Pull the newest version from the DockerHub. If your version is already the latest, just go to step 2.
    ```
    docker pull dockerhy/linux-dbg-loogarch
    ```
2. Run the following command in the working directory:
    - On Mac:
    ```
    docker run --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp dockerhy/linux-dbg-loogarch ${CMD}
    ```
    - On Windows:
    ```
    docker run --rm -v %cd%:/usr/src/myapp -w /usr/src/myapp dockerhy/linux-dbg-loogarch ${CMD}
    ```
    where `${CMD}` could be any command that is supported by this image, such as `make`, `make clean`.
