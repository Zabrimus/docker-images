ARG ARCH=
FROM ${ARCH}debian:bookworm-slim

ENV USER=browser USER_ID=1000 USER_GID=1000

RUN apt update && \
    apt -y install libssl3 libglib2.0-0 libnss3 libatk1.0-0 libatk-bridge2.0-0 libcups2 libxcomposite1 \
                libxdamage1 libxrandr2 libgbm1 libxkbcommon0 libpango1.0-0 libasound2 \
                libfmt9 libxfixes3 libegl1-mesa libpci3 bash sudo && \
    apt clean && apt -y autoremove && rm -rf /var/lib/apt/lists/*

RUN groupadd --gid "${USER_GID}" "${USER}" && \
    useradd \
      --uid ${USER_ID} \
      --gid ${USER_GID} \
      --home /app \
      --shell /bin/bash \
      ${USER}

COPY start.sh /
RUN chmod u+x start.sh

WORKDIR /app

EXPOSE 50001/tcp

ENTRYPOINT ["/start.sh"]

# Start with:
# As user with uid 1000, gid 1000
# docker run -it --rm -v .:/app -v /dev/shm:/dev/shm --ipc="host" --net=host -e UID=1000 -e GID=1000 <imagename> -user -ini sockets.ini
# or as root (e.g. in CoreELEC or LibreELEC)
# docker run -it --rm -v .:/app -v /dev/shm:/dev/shm --ipc="host" --net=host <imagename> -ini sockets.ini

