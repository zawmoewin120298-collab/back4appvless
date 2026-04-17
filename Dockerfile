FROM alpine:latest

ENV PORT=8080
# Cloudflare Token ကို Environment Variable အနေနဲ့ ထည့်ထားနိုင်ပါတယ်
ENV TUNNEL_TOKEN=YOUR_TOKEN_HERE

RUN apk add --no-cache curl unzip

# V2Ray တင်ခြင်း
RUN curl -L -o v2ray.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip && \
    mkdir /v2ray && \
    unzip v2ray.zip -d /v2ray && \
    rm v2ray.zip

COPY config.json /v2ray/config.json

# Cloudflare Tunnel (cloudflared) ကို ဒေါင်းလုဒ်ဆွဲခြင်း
RUN curl -L -o /usr/local/bin/cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 && \
    chmod +x /usr/local/bin/cloudflared

EXPOSE 8080

# Token ကို အသုံးပြုပြီး Tunnel ကို run မယ်
CMD /v2ray/v2ray run -config /v2ray/config.json & cloudflared tunnel --no-autoupdate run --token ${TUNNEL_TOKEN}

