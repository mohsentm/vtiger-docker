FROM php:5.6-apache

LABEL maintainer="hosseini.m1370@gmail.com"
LABEL version="7.1.0"
LABEL description="Vtiger crm"

ENV INSTALL_DIR /var/www/html

# Use the default production configuration
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"


RUN sed -i "s/Options Indexes FollowSymLinks/Options FollowSymLinks/" /etc/apache2/apache2.conf

RUN requirements="zip wget curl libpng-dev zlib1g-dev libfreetype6-dev libjpeg62-turbo-dev" \
    && apt-get update -y \
    && apt-get install -y $requirements

RUN apt-get update \
  && apt-get install -y zlib1g-dev libicu-dev g++ \
  && docker-php-ext-configure intl \
  && docker-php-ext-install intl

RUN docker-php-ext-install  mysqli zip

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/  &&  \
    docker-php-ext-install gd

RUN a2enmod rewrite expires

# install the PHP extensions we need
RUN apt-get update && apt-get install -y cron curl wget libpng-dev libjpeg-dev libkrb5-dev zlib1g-dev \
    && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-install gd mysqli \
    && apt-get -y install libssl-dev libc-client2007e-dev libkrb5-dev \
    && docker-php-ext-configure imap --with-imap-ssl --with-kerberos \
    && docker-php-ext-install imap opcache zip\
&& rm -rf /var/lib/apt/lists/*

# setting the recommended for vtiger
RUN { \
        echo 'display_errors=Off'; \
        echo 'max_execution_time=60'; \
        echo 'error_reporting=E_ERROR & ~E_NOTICE & ~E_STRICT & ~E_DEPRECATED'; \
        echo 'log_errors=On'; \
        echo 'short_open_tag=Off'; \
        echo 'upload_max_filesize=5M'; \
        echo 'sql.safe_mode=Off'; \
        echo 'max_input_vars=10000'; \
        echo 'memory_limit=512M'; \
        echo 'post_max_size=128M'; \
        echo 'max_input_time=120'; \
        echo 'upload_max_size=5M'; \
        echo 'register_globals=Off'; \
        echo 'output_buffering=On'; \
        echo 'allow_call_time_reference=On'; \
        echo 'suhosin.simulation=On'; \
    } > /usr/local/etc/php/conf.d/vtiger-recommended.ini

# setting the reccomended for apcache
# https://secure.php.net/manual/en/opcache.installation.php
RUN { \
        echo 'opcache.memory_consumption=128'; \
        echo 'opcache.interned_strings_buffer=8'; \
        echo 'opcache.max_accelerated_files=4000'; \
        echo 'opcache.revalidate_freq=60'; \
        echo 'opcache.fast_shutdown=1'; \
        echo 'opcache.enable_cli=1'; \
} > /usr/local/etc/php/conf.d/opcache-recommended.ini

RUN chsh -s /bin/bash www-data

# Add cron job
ADD crontab /etc/cron.d/vtigercrm-cron
RUN chmod 0644 /etc/cron.d/vtigercrm-cron \
    && crontab -u www-data /etc/cron.d/vtigercrm-cron

VOLUME ["$INSTALL_DIR"]

WORKDIR $INSTALL_DIR
