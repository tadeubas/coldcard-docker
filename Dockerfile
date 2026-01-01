FROM gcc:11.5.0-bullseye

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    git make \
    python3 python3-venv python3-pip python-is-python3 \
    swig \
    libpcsclite-dev pcscd \
    pkg-config libffi-dev libudev-dev \
    xterm \
    autoconf automake libtool m4

WORKDIR /build

RUN git clone --recursive https://github.com/Coldcard/firmware.git \
 && cd firmware \
 && pip install --no-cache-dir -U pip setuptools \
 && pip install --no-cache-dir -r requirements.txt \
 && pip install --no-cache-dir pysdl2-dll \
 && cd unix \
 && make -C ../external/micropython/mpy-cross \
 && make setup \
 && make ngu-setup \
 && make \
 && find /build/firmware -name ".git" -type d -prune -exec rm -rf '{}' +

WORKDIR /build/firmware/unix

 CMD ["./simulator.py"]
