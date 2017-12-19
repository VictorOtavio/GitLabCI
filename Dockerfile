FROM php:7.1

MAINTAINER CodeDev <contato@codedev.com.br>

# Update packages and install dependencies
RUN apt-get update -yqq && apt-get install git \
    libcurl4-gnutls-dev libicu-dev libmcrypt-dev \
    libvpx-dev libjpeg-dev libpng-dev libxpm-dev \
    zlib1g-dev libfreetype6-dev libxml2-dev \
    libexpat1-dev libbz2-dev libgmp3-dev libldap2-dev \
    unixodbc-dev libpq-dev libsqlite3-dev libaspell-dev \
    libsnmp-dev libpcre3-dev libtidy-dev gnupg openssh-client -yqq

# Install php extensions
RUN docker-php-ext-install mbstring pdo_mysql curl json intl gd xml zip bz2 opcache

# Install & enable mcrypt
RUN docker-php-ext-configure mcrypt && \
    docker-php-ext-install mcrypt

# Install & enable Xdebug for code coverage reports
RUN pecl install xdebug && \
    docker-php-ext-enable xdebug

# Install Composer and project dependencies.
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

# Upgrade to Node 8
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install nodejs

# SSH Folder
RUN mkdir -p ~/.ssh

CMD ["bash"]
