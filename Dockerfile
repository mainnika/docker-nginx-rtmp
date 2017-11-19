FROM gentoo/stage3-amd64

RUN emerge --sync \
    && mkdir -p /etc/portage/package.use \
    && echo 'www-servers/nginx rtmp' > /etc/portage/package.use/nginx \
    && sed -i 's/-O2 -pipe/-Ofast -pipe/g' /etc/portage/make.conf \
    && emerge www-servers/nginx \
    && rm -rf /usr/portage/*

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80 1935

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]