# docker-rootless-debian
## _Rootless Docker in a Debian Bullseye Container_

## Have you ever...

- been concerned by the amount of security given to your build container?
- been bitten by spotty DNS issues in the `docker`, `docker:dind`, and `docker:dind-rootless` containers?
- felt frustrated by the lack of documentation when building your own rootless Docker container?

**Worry no more!**

`docker-rootless-debian` is a Debian container built with the specific purpose of building other containers. It can be used in Docker and in Kubernetes with a minimum of permissions. It can also be the base container for more complex ideas, like a rootless container builder for your favorite CI tool.

## Features

- Minimum packages necessary to run Docker in rootless mode
- Able to run `docker-compose` without special tricks
- Image can run with either `vfs` or `fuse-overlay2` for its storage driver (default is `vfs`)

## Building

    $ git clone https://github.com/ccureau/docker-rootless-debian.git
    $ docker build -t rootless:latest .

## Usage

    $ docker run --rm -d --name rootless --privileged rootless:latest
    $ docker exec -it rootless bash
    
    rootless@9c047b0cbe09:/$ whoami
    rootless
    rootless@9c047b0cbe09:/$ docker run --rm -it hello-world
    
    Hello from Docker!
    This message shows that your installation appears to be working correctly.
    
    To generate this message, Docker took the following steps:
     1. The Docker client contacted the Docker daemon.
     2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
        (amd64)
     3. The Docker daemon created a new container from that image which runs the
        executable that produces the output you are currently reading.
     4. The Docker daemon streamed that output to the Docker client, which sent it
        to your terminal.
    
    To try something more ambitious, you can run an Ubuntu container with:
     $ docker run -it ubuntu bash
    
    Share images, automate workflows, and more with a free Docker ID:
     https://hub.docker.com/
    
    For more examples and ideas, visit:
     https://docs.docker.com/get-started/
    
    rootless@9c047b0cbe09:/$ 

## Development

Want to contribute? Great! Issues are welcome; Pull Requests are better.


## License

MIT

**Free Software, Hell Yeah!**
