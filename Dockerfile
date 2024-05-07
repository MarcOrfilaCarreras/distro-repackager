FROM ubuntu:jammy

LABEL maintainer="https://github.com/MarcOrfilaCarreras"

RUN mkdir /app

WORKDIR /app

COPY run.sh /app/run.sh
COPY commands /app/commands
COPY common /app/common

RUN ./run.sh dependencies --install
RUN rm -rf /var/lib/apt/lists/*

COPY distros /app/distros

ENTRYPOINT [ "./run.sh" ]
CMD [ "--help" ]
