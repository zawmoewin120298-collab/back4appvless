FROM alpine:latest

# UUID နဲ့ PORT ကို Environment အနေနဲ့ သတ်မှတ်မယ်
ENV UUID=f2e17b4d-22fd-44a4-90db-40649717be8e
ENV PORT=8080

RUN apk add --no-cache curl unzip

# V2Ray တင်ခြင်း (Sing-box သုံးနေတယ်ဆိုရင် Sing-box binary ကို ပြောင်းတင်ပါ)
RUN curl -L -o v2ray.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip && \
    mkdir /v2ray && \
    unzip v2ray.zip -d /v2ray && \
    rm v2ray.zip

COPY config.json /v2ray/config.json

# ဒီနေရာမှာ Port ကို ပွင့်အောင်လုပ်ပေးရမယ်
EXPOSE 8080

CMD /v2ray/v2ray run -config /v2ray/config.json

