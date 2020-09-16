FROM php:7.3.6-fpm-alpine3.9
RUN apk add bash mysql-client
RUN docker-php-ext-install pdo pdo_mysql

RUN apk add --no-cache shadow

WORKDIR /var/www
RUN rm -rf /var/www/html

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# RUN composer install && \
#     cp .env.example .env && \
#     php artisan key:generate && \
#     php artisan config:cache

# COPY . /var/www 

RUN chown -R www-data:www-data /var/www
RUN chmod -R 755 /var/www/

RUN ln -s public html

RUN usermod -u 1000 www-data
USER www-data



EXPOSE 9000
ENTRYPOINT "php-fpm"

