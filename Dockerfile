FROM phusion/baseimage

RUN mkdir /mymdb

WORKDIR /mymdb

COPY requirements* /mymdb/

COPY django /mymdb/django

COPY scripts /mymdb/scripts

RUN mkdir /var/log/mymdb/ \
    && touch /var/log/mymdb/mymdb.log \
    && apt-get -y update \
    && apt-get install -y \
       nginx \
       postgresql-client \
       python3 \
       python3-pip \
    && pip3 install virtualenv \
    && virtualenv /mymdb/venv \
    && bash /mymdb/scripts/pip_install.sh /mymdb \
    && bash /mymdb/scripts/collect_static.sh /mymdb

#-- Configure nginx
COPY nginx/mymdb.conf /etc/nginx/sites-available/mymdb.conf

RUN rm /etc/nginx/sites-enabled/* \
    && ln -s /etc/nginx/sites-available/mymdb.conf /etc/nginx/sites-enabled/mymdb.conf

COPY runit/nginx /etc/service/nginx

RUN chmod +x /etc/service/nginx/run

#-- Configure uwsgi
COPY uwsgi/mymdb.ini /etc/uwsgi/apps-enabled/mymdb.ini

RUN mkdir -p /var/log/uwsgi/ \
    && touch /var/log/uwsgi/mymdb.log \
    && chown www-data /var/log/uwsgi/mymdb.log \
    && chown www-data /var/log/mymdb/mymdb.log

COPY runit/uwsgi /etc/service/uwsgi

RUN chmod +x /etc/service/uwsgi/run

#-- Clean up and expose port
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* tmp/* var/tmp/*

EXPOSE 80

