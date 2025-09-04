FROM ghcr.io/astral-sh/uv:0.7.21 AS uv
FROM debian:12.11-slim

ARG USER=vscode
ARG GROUP=${USER}
ARG UID
ARG GID
ARG WORKDIR=/app

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    bash-completion=1:2.11-6 \
    git=1:2.39.5-0+deb12u2 \
    sudo=1.9.13p3-1+deb12u2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN groupadd --gid ${GID} ${GROUP} && \
    useradd --uid ${UID} --gid ${GID} --groups sudo --shell /bin/bash --create-home ${USER} && \
    echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

COPY --from=uv /uv /uvx /bin/

USER ${USER}
WORKDIR ${WORKDIR}
COPY --chown=${USER}:${GROUP} .python-version pyproject.toml uv.lock ./
# RUN uv python install && uv sync --frozen
