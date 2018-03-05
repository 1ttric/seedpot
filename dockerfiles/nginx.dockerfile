FROM nginx:alpine

FROM jwilder/dockerize
COPY --from=0 / /

ENTRYPOINT apk add --no-cache apache2-utils \
    && mkdir /htpasswd/ \
    && htpasswd -bc /htpasswd/.htpasswd $HTTP_USER $HTTP_PASSWORD \
    && dockerize \
        -wait http://openvpn:80 \
        -wait http://openvpn:9117 \
        -wait http://openvpn:7878 \
        -wait http://openvpn:8989 \
        -timeout 2m \
        nginx -g "daemon off;"
