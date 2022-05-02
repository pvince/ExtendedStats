#preliminary stuff
FROM ubuntu:16.04
MAINTAINER Jay Atkinson <jgatkinsn@gmail.com>


#install basics
RUN apt-get update
RUN apt-get install -y python2.7
RUN apt-get install -y python-pymysql
RUN apt-get install -y apache2
# blocker for ubuntu 18.04: https://serverfault.com/questions/949991/how-to-install-tzdata-on-a-ubuntu-docker-image
RUN apt-get install -y python-django
RUN apt-get install -y mysql-client
RUN apt-get install -y libapache2-mod-wsgi
RUN apt-get install -y python-imaging
RUN apt-get install -y supervisor
RUN apt-get install -y cron
RUN apt-get install -y curl
RUN apt-get install -y python-requests
RUN apt-get install -y language-pack-en-base
RUN dpkg-reconfigure locales
# not needed
RUN apt-get install -y nano

ENV DBUSER root
ENV DBPASS basilisk

#expose the basic web ports
EXPOSE 80 8080

#setup apache2
RUN mkdir -p /var/lock/apache2
RUN mkdir -p /var/run/apache2
#ENV APACHE_RUN_USER www-data
#ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
RUN chmod -R 777 /var/www
RUN chgrp -R www-data /var/www
COPY stats.conf /etc/apache2/conf-enabled/
RUN a2enmod wsgi

#setup supervisord
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

#add cronjob
COPY crons.conf /etc/cron.d/extended
RUN chmod 0644 /etc/cron.d/extended
RUN crontab /etc/cron.d/extended


#install files
RUN mkdir -p /home/ubuntu/extended/db
COPY . /home/ubuntu/extended/
RUN chmod -R 777 /home/ubuntu/extended
RUN chgrp -R www-data /home/ubuntu/extended
RUN chmod +x /home/ubuntu/extended/setup_mysql.sh

#start supervisor which starts web & mysql
CMD ["/usr/bin/supervisord"]
