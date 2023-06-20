FROM alpine:3.16

RUN	apk update && apk upgrade && apk add --no-cache nginx openssl

RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/manugarc.42.fr.key -out /etc/nginx/ssl/manugarc.42.fr.crt -subj "/CN=manugarc.42.fr"

# Copy custom NGINX configuration file
COPY ./requirements/nginx/conf/nginx.conf /etc/nginx/http.d/default.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
