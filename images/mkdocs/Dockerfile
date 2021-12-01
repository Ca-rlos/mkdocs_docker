FROM python:3
USER root
WORKDIR /usr/src/mkdocs

RUN apt-get update
RUN apt-get install -y mkdocs
ENTRYPOINT /usr/bin/mkdocs build && tar -cvf site.tar site --remove-files

