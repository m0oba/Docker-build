FROM arm32v6/alpine:3.9

RUN apk add --update --no-cache make gcc g++ python linux-headers udev nodejs npm git
RUN git clone --branch homie-convention https://github.com/rtreffer/zigbee2mqtt.git /app
WORKDIR /app
RUN npm install --unsafe-perm
RUN apk del make gcc g++ python linux-headers udev git
RUN chmod +x /app/docker/run.sh
# Entrypoint
ENTRYPOINT ["/app/docker/run.sh"]
