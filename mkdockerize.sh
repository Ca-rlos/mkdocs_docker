#!/bin/bash

docker image build -f images/mkdocs/Dockerfile . -t mkdocs:latest
docker run -v ${PWD}/mkdocs:/usr/src/mkdocs --rm mkdocs
docker image build -f images/nginx/Dockerfile . -t serve_site:latest
docker rm -f serve_site || true
docker run -d -p 8000:80 --name serve_site serve_site
