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
    php7.1 \
    php7.1-cli \
    libapache2-mod-php7.1 \
    composer

ADD 000-default.conf /etc/apache2/sites-available/000-default.conf

WORKDIR /var/www/html

ADD ./ .

#Comando para alterar o Dono de algum diretorio
#RUN chown -R www-data:www-data /var/www/html && chmod -R 777 /var/www/html

#Comando para dar permissao a algum diretorio
RUN chmod -R 777 /var/www/html

#RUN a2enmod rewrite

#EXPOSE 80

RUN cp -av index.php ./app
CMD ["apachectl", "-D", "FOREGROUND"]
