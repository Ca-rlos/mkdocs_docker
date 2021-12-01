# MkDocs Service

Two Docker images to create and serve MkDocs contents!

## Background

I wanted to serve MkDocs through Nginx on Docker, so I decided to create 2 images:

* A Python3-based MkDocs image that generates the HTML contents and puts them in a tar.
* An Nginx image that takes the tar's contents and servers them internally on port 80 and externally on 8000.

There are still some improvemenets that could be made (e. g. Using Alpine instead of Debian images...).

## Getting Started

These instructions will get you up and running in *nix systems.

### Prerequisites

* Docker
* An internet connection

### Installing

You can use the following shell script to build/run both images and start the Nginx instance. Make sure to execute it from within the project's directory (it relies on relative paths).

```
./mkdockerize.sh
```

If you're using Jenkins, you can also use the Jenkinsfile to make a pipeline that will build, serve and perform a simple test.

### How it works

This project follows 5 steps and performs 1 test if using Jenkins:

1. An image ('mkdocs') is built from ./images/mkdocs/Dockerfile
2. A container based on the mkdocs image is spawned and performs the following tasks:
   * Installs MkDocs.
   * Using MkDocs, builds the HTML content based on the files found in the ./mkdocs directory.
   * Makes a tar file (site.tar) with the images and, if successful, removes the original output directory ('site').
3. Another image ('serve_site') is built from ./images/nginx/Dockerfile.
4. A bash command checks for previous versions of the serve_site container and removes them (to avoid port conflicts).
5. A container based on the serve_site Nginx image is spawned and performs the following tasks:
   * Copies the site.tar file in the host's filesystem to the container.
   * Extracts the contents of site.tar and moves them to Nginx's default static contents directory, removing the empty site directory afterwards.
6. (Jenkins test) A simple GET using curl is performed to confirm the content is being served from the target port (8000).
