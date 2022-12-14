FROM php:8.1-fpm

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get install -y \
        curl \
        nano \
        git \
        unzip \
        libxml2-dev \
        libpng-dev \
        libzip-dev \
        libxslt-dev \
        imagemagick\
        libmagickwand-dev \
        wget \
        htop \
        python3 \
        libpcre3-dev

RUN docker-php-ext-install pdo_mysql bcmath dom intl zip xsl simplexml sysvsem pcntl gd mysqli
COPY fpm.conf /usr/local/etc/php-fpm.d/zz-docker.conf
RUN pecl install xdebug imagick psr phalcon && docker-php-ext-enable xdebug imagick psr phalcon \
    && echo 'xdebug.client_port=9003' >> /usr/local/etc/php/php.ini \
    && echo 'xdebug.mode=debug' >> /usr/local/etc/php/php.ini \
    && echo "xdebug.client_host = host.docker.internal" >> /usr/local/etc/php/php.ini