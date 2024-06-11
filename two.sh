#!/bin/bash
# Устанавливаем путь по умолчанию, если ключ -d не указан
ROOT_DIR="/"

# Проверяем наличие ключа -d и устанавливаем ROOT_DIR
while getopts "d:" opt; do
  case ${opt} in
    d ) ROOT_DIR=$OPTARG ;;
    \? ) echo "Usage: $0 -d <root_directory>"; exit 1 ;;
  esac
done

# Считываем список пользователей
USERS=$(cut -d: -f1 /etc/passwd)

# Создаем каждому пользователю директорию и устанавливаем права
for USER in $USERS; do
  USER_DIR="$ROOT_DIR/$USER"
  if [ ! -d "$USER_DIR" ]; then
    mkdir "$USER_DIR"
    chmod 755 "$USER_DIR"
    chown "$USER:$USER" "$USER_DIR"
    echo "Created directory for user $USER at $USER_DIR" | tee -a logs.txt 
  else
    echo "Directory for user $USER already exists at $USER_DIR" | tee -a logs.txt
  fi
done

