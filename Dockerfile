FROM php:7.2

MAINTAINER CodeDev <contato@codedev.com.br>

RUN apt-get update -yqq && apt-get install -yqq \
    git \
    gnupg \
    openssh-client \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libxpm-dev \
    libsqlite3-dev \
    zlib1g-dev \
    --no-install-recommends
    
RUN docker-php-ext-install zip \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug

# PHP Composer
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

# Node, NPM e Yarn
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
    && apt-get install nodejs -yqq \
    && npm install --global yarn

# Finalização
RUN rm -rf /var/lib/apt/lists/* \
    && apt-get autoremove -y \
    && mkdir -p ~/.ssh

CMD ["php", "-a"]
