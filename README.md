docker pull xtechcloud/omo-proxy

docker run --restart=always --name=omo-proxy -p 2222:22 -p 80:80 -p 443:443 -d xtechcloud/omo-proxy
