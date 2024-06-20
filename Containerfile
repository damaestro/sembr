FROM registry.fedoraproject.org/fedora

# Install build dependencies and tools
RUN dnf --refresh -y install \
    git \
    python3-pip \
    python3-setuptools \
    python3-setuptools_scm+toml \
    python3-devel \
    python3-torch \
    python3-numpy \
    python3-tqdm \
    python3-requests \
    python3-pyyaml \
    python3-regex \
    python3-flask

# Create our virtual user for runtime inside the container
RUN set -ex; \
    useradd -m -g users -s /bin/bash sembr; \
    passwd sembr -d;
WORKDIR /home/sembr
USER sembr

# Install SemBr (from PyPI)
RUN pip install sembr

# Check environment is sane
RUN pip check

ENTRYPOINT ["/home/sembr/.local/bin/sembr"]
