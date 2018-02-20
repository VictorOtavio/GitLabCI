FROM php:7.1

MAINTAINER CodeDev <contato@codedev.com.br>

RUN apt-get update -yqq && apt-get install -yqq \
    g++ \
    git \
    gnupg \
    openssh-client \
    libaspell-dev \
    libbz2-dev \
    libcurl4-gnutls-dev \
    libexpat1-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
    libgmp3-dev \
    libicu-dev \
    libjpeg-dev \
    libldap2-dev \
    libpcre3-dev \
    libpq-dev \
    libsnmp-dev \
    libsqlite3-dev \
    libtidy-dev \
    libvpx-dev \
    libxml2-dev \
    libxpm-dev \
    unixodbc-dev \
    zlib1g-dev \
    libmagickwand-dev --no-install-recommends

RUN docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && docker-php-ext-install curl \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install soap \
    && docker-php-ext-install json \
    && docker-php-ext-install xml \
    && docker-php-ext-install zip \
    && docker-php-ext-install bz2 \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install iconv \
    && docker-php-ext-configure mcrypt \
    && docker-php-ext-install mcrypt \
    && docker-php-ext-install opcache \
    && pecl install imagick  \
    && docker-php-ext-enable imagick \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug\
    && pecl install apcu \
    && docker-php-ext-enable apcu

RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
    && apt-get install nodejs \
    && npm install --global yarn \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get autoremove -y \
    && mkdir -p ~/.ssh

COPY ./opcache.ini /usr/local/etc/php/conf.d/opcache.ini

CMD ["php-fpm"]
