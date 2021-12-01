FROM nginx
WORKDIR /usr/src/mkdocs
 
COPY ./mkdocs/site.tar site.tar 
RUN tar -xf site.tar
RUN mv -f site/* /usr/share/nginx/html && rm -rf site
