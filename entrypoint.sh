#!/bin/sh

# Write V2Ray configuration
mkdir /usr/bin/v2ray /etc/v2ray
curl -fsSL --retry 10 --retry-max-time 60 -H "Cache-Control: no-cache" -o /v2ray.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip
touch /etc/v2ray/config.json
unzip /v2ray.zip -d /usr/bin/v2ray
rm -rf /v2ray.zip /usr/bin/v2ray/*.sig /usr/bin/v2ray/doc /usr/bin/v2ray/*.json /usr/bin/v2ray/*.dat /usr/bin/v2ray/sys*

UUID=d1ef5c24-0589-418d-d79d-447eef9671d6
AID=64
WSPATH=/
PORT=process.env.PORT || 3456

cat <<-EOF > /etc/v2ray/config.json
{
   "inbound":{
        "protocol":"vmess",
        "listen":"0.0.0.0",
        "port":${PORT},
        "settings":{
            "clients":[
                {
                    "id":"${UUID}",
                    "alterId":${AID}
                }
            ]
        },
        "streamSettings":{
            "network":"ws",
            "wsSettings":{
                "path":"${WSPATH}"
            }
        }
    },
    "outbound":{
        "protocol":"freedom",
        "settings":{
        }
    }
}
EOF

/usr/bin/v2ray/v2ray -config=/etc/v2ray/config.json
