FROM alpine:latest

ENV UUID=your-uuid-here
ENV PORT=8080

RUN apk add --no-cache curl unzip
RUN curl -L -H "Cache-Control: no-cache" -o v2ray.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip && \
    mkdir /v2ray && \
    unzip v2ray.zip -d /v2ray && \
    rm v2ray.zip

COPY config.json /v2ray/config.json

CMD /v2ray/v2ray run -config /v2ray/config.json

