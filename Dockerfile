FROM alpine:latest
LABEL maintainer="jonathan@pulsifer.ca"

ENV HUGO_VERSION 0.29

RUN addgroup -Sg 1000 hugo && adduser -SH -u 1000 -G hugo hugo

ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz /tmp
ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_checksums.txt /tmp

RUN apk upgrade && apk add --no-cache tini \
 && cd /tmp \
 && grep hugo_${HUGO_VERSION}_Linux-64bit.tar.gz hugo_${HUGO_VERSION}_checksums.txt | sha256sum -c - \
 && tar -xvf /tmp/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz -C /tmp/ \
 && mv -v /tmp/hugo /usr/bin/hugo \
 && chmod +x /usr/bin/hugo \
 && rm -vf /tmp/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz \
 && mkdir -vp /var/www \
 && chown -R hugo:hugo /var/www

USER 1000
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/usr/bin/hugo", "server", "--disableLiveReload", "--watch=false", "--bind=0.0.0.0", "--source=/var/www"]
