FROM nginx:alpine

FROM jwilder/dockerize
COPY --from=0 / /
ENTRYPOINT dockerize \
        -wait http://openvpn:80 \
        -wait http://openvpn:9117 \
        -wait http://openvpn:7878 \
        -wait http://openvpn:8989 \
        -timeout 2m \
    nginx -g "daemon off;"