FROM praqma/network-multitool:latest

ENV APP_UID=9999
ENV APP_GID=9999
ENV APP_USER=node
ENV HTTPS_PORT=8443
ENV HTTP_PORT=8080

RUN addgroup -S -g $APP_GID $APP_USER \
	&& adduser -S -u $APP_UID -G $APP_USER $APP_USER \
	&& chown -R $APP_UID:$APP_GID /etc/nginx/ /usr/share/nginx /var/lib/nginx /certs \
	&& chown -R $APP_UID:$APP_GID /var/cache \
	&& chown -R $APP_UID:$APP_GID /var/log/nginx \
	&& chown -R $APP_UID:$APP_GID /run \
	&& rm -rf /var/cache/apk/*

USER $APP_UID

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE $HTTPS_PORT $HTTP_PORT

# Start nginx in foreground:
CMD ["nginx", "-g", "daemon off;"]
