# Step 1: ပေါ့ပါးတဲ့ Alpine Linux ကို သုံးမယ်
FROM alpine:latest

# Step 2: လိုအပ်တဲ့ အချက်အလက်များကို Environment Variable အဖြစ် သတ်မှတ်မယ်
ENV PORT=8080
ENV TUNNEL_TOKEN=YOUR_TOKEN_HERE

# Step 3: လိုအပ်တဲ့ Tools များ သွင်းယူခြင်း
RUN apk add --no-cache curl unzip libc6-compat

# Step 4: V2Ray Core ကို Install လုပ်ခြင်း
RUN curl -L -o v2ray.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip && \
    mkdir -p /v2ray && \
    unzip v2ray.zip -d /v2ray && \
    rm v2ray.zip && \
    chmod +x /v2ray/v2ray

# Step 5: Cloudflare Tunnel (cloudflared) ကို Install လုပ်ခြင်း
RUN curl -L -o /usr/local/bin/cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 && \
    chmod +x /usr/local/bin/cloudflared

# Step 6: Config ဖိုင်ကို Copy ကူးထည့်မယ်
# (အစ်ကို့ရဲ့ config.json ထဲမှာ port ကို 8080 လို့ ပြင်ထားဖို့ လိုပါတယ်)
COPY config.json /v2ray/config.json

# Step 7: Port ဖွင့်ပေးခြင်း
EXPOSE 8080

# Step 8: V2Ray နဲ့ Cloudflare Tunnel ကို အတူတကွ Run ခြင်း
# 'wait -n' က service တစ်ခုခု သေသွားရင် container ကို အလိုအလျောက် ပိတ်ပေးမှာပါ
CMD /v2ray/v2ray run -config /v2ray/config.json & \
    cloudflared tunnel --no-autoupdate run --token ${TUNNEL_TOKEN} & \
    wait -n
