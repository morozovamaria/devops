# Указываем базовый образ
FROM nginx:latest

# Информация о создателе образа
MAINTAINER maria

# Обновляем пакеты и устанавливаем PostgreSQL
RUN apt-get update && apt-get install -y postgresql postgresql-contrib

# Копируем конфигурационный файл Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Устанавливаем рабочую директорию
WORKDIR /var/www/html

# Определяем переменные окружения
ENV POSTGRES_USER=myuser
ENV POSTGRES_PASSWORD=mypassword
ENV POSTGRES_DB=mydatabase

# Добавляем картинку в котиком
ADD cat.jpg /wsl.localhost/Ubuntu

# Создаем Docker Volume для данных PostgreSQL
VOLUME ["/var/lib/postgresql/data"]

# Устанавливаем пользователя
USER nginx

# Открываем порт 80
EXPOSE 80

# Команда для запуска Nginx в фоновом режиме
CMD ["nginx", "-g", "daemon off;"]
