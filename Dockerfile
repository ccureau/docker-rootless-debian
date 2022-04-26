FROM debian:bullseye

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y \
        ca-certificates \
        curl \
        wget \
        gnupg \
        lsb-release \
        curl && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get -y install \
        uidmap \
        iproute2 \
        docker-ce \
        docker-ce-cli \
        containerd.io \
        docker-ce-rootless-extras \
        slirp4netns \
        iptables \
        dbus-user-session \
        fuse-overlayfs && \
    apt-get clean

# "/run/user/UID" will be used by default as the value of XDG_RUNTIME_DIR
RUN mkdir /run/user && chmod 1777 /run/user

# create a default user preconfigured for running rootless dockerd
RUN set -eux && \
	useradd -m -c 'Rootless' -u 1000 rootless

# make sure we're using iptables-legacy
RUN update-alternatives --set iptables /usr/sbin/iptables-legacy && \
    update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy

USER rootless

# iptables doesn't exist as a module, so skip it
RUN dockerd-rootless-setuptool.sh install --skip-iptables

ENV XDG_RUNTIME_DIR=/home/rootless/.docker/run
ENV DOCKER_HOST=unix:///home/rootless/.docker/run/docker.sock

ENTRYPOINT ["dockerd-rootless.sh","--storage-driver","vfs"]
