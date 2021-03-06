FROM debian:stretch-slim

LABEL maintainer="devops@flaconi.de"

ARG ANSIBLE_VERSION=

RUN set -x \
	&& DEBIAN_FRONTEND=noninteractive \
	&& apt-get update -y \
	&& apt-get install --no-install-recommends --no-install-suggests -y \
		apt-transport-https \
		bc \
		ca-certificates \
		git \
		gnupg \
		libssl-dev \
		python-dev \
		python-setuptools \
		python-wheel \
		python-pip \
		python-cffi \
		build-essential \
	&& if [ -z "${ANSIBLE_VERSION}" ]; then \
			pip install --no-cache-dir ansible;\
		else \
			pip install --no-cache-dir "ansible>=${ANSIBLE_VERSION},<$(echo "${ANSIBLE_VERSION}+0.1" | bc)"; \
		fi \
	&& pip install --no-cache-dir \
		jmespath \
		pyaml \
	&& apt-get remove -f -y --purge --auto-remove build-essential bc \
	&& apt-get clean \
	&& apt-get autoremove -y \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /root/.cache
