FROM debian:9-slim

# set the environment variables
ENV EVENTS noninteractive
ENV TERM dumb

USER root

# install utilities
RUN apt-get clean && apt-get update && \
		apt-get -y install curl wget vim git mc screen net-tools nano

# install generic services
RUN apt-get -y install openssh-server

# configure root user
RUN usermod --password "`openssl passwd root`" root
RUN sed -i -e 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

# install nginx
RUN apt-get -y install nginx
COPY ./.docker/settings/nginx.default /etc/nginx/sites-available/default

# install database packages
RUN apt-get -y install mariadb-client

# install php
RUN apt install -y apt-transport-https lsb-release ca-certificates
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list
RUN apt update

RUN apt install -y php7.4 php7.4-cli php7.4-common php7.4-curl php7.4-dev php7.4-gd \
    php7.4-json php7.4-memcached php7.4-mysql php7.4-readline \
    php7.4-mbstring php7.4-dom php7.4-zip php7.4-bcmath php7.4-fpm
COPY ./.docker/settings/cli.php.ini    /etc/php/7.4/cli/php.ini
COPY ./.docker/settings/fpm.php.ini    /etc/php/7.4/fpm/php.ini

# Configure PHP-FPM
COPY ./.docker/settings/fpm.www.conf /etc/php7/php-fpm.d/www.conf
#COPY ./.docker/settings/php.ini /etc/php7/conf.d/custom.ini

# Setup document root
RUN mkdir -p /var/www/html
#RUN php -v

# Add application
WORKDIR /var/www/html

# Install composer from the official image
COPY --from=composer /usr/bin/composer /usr/bin/composer

# configure root user
RUN usermod --password "`openssl passwd root`" root
RUN sed -i -e 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

# install src
COPY . /var/www/html

# install the runables
COPY ./.docker/runables/deploy.sh /opt/deploy.sh
COPY ./.docker/runables/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /opt/deploy.sh

# start command
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]