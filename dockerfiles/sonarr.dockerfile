FROM linuxserver/sonarr

FROM jwilder/dockerize
COPY --from=0 / /
ENTRYPOINT dockerize \
        -wait http://localhost:80 \
        -wait http://localhost:9117 \
        -timeout 1m \
    /init