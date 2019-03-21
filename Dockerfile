FROM debian:latest

MAINTAINER Alysson Vicuña <alysson.vicuna@gmail.com>
ARG TIME_ZONE="America/Sao_Paulo"
# Set the timezone.
RUN echo ${TIME_ZONE} > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

RUN apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y \
    apache2 \
    php7.0 \
    php7.0-cli \
    libapache2-mod-php7.0 \
    composer

ADD 000-default.conf /etc/apache2/sites-available/000-default.conf

WORKDIR /var/www/html

ADD index.php /var/www/html

#Comando para alterar o Dono de algum diretorio
#RUN chown -R www-data:www-data /var/www/html && chmod -R 777 /var/www/html

#Comando para dar permissao a algum diretorio
RUN chmod -R 777 /var/www/html

CMD ["apachectl", "-D", "FOREGROUND"]
