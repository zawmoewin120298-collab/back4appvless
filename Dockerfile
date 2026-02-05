FROM teddysun/xray:latest

# Config ဖိုင်ကို သတ်မှတ်ထားတဲ့ နေရာထဲ ထည့်မယ်
COPY config.json /etc/xray/config.json

# Port 8080 ကို ဖွင့်ပေးမယ် (Back4app default)
EXPOSE 8080

# Xray ကို စတင် Run မယ်
CMD ["xray", "-config", "/etc/xray/config.json"]

