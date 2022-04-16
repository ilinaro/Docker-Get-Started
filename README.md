- Официальный Dockerfile для NEXT JS 
https://github.com/vercel/next.js/blob/canary/examples/with-docker/Dockerfile

- Официальный ENV-MULTI для NEXT JS 
 https://github.com/vercel/next.js/tree/canary/examples/with-docker-multi-env

- Документация для Node JS 
https://github.com/nodejs/docker-node/tree/b4117f9333da4138b03a546ec926ef50a31506c3#nodealpine

# Docker-Get-Started

```d
% docker version
```

#### Пример запуска

- Dockerfile

```go
FROM python     // взять образ Python

WORKDIR /app    // рабочая директория

COPY .  .       // копирование файлов

CMD ["python", "index.py"]
```

Запуск

```d
% docker build .
% docker image ls
% docker run [IMAGE ID]
```


Теория: Контейнер и образ

IMAGE <--- read --- CONTAINER

IMAGE - это некоторые шаблоны из которые служат, чтобы из них создавались CONTAINER

IMAGE служат только для чтения, так как он фиксированый


#### Работа с Node JS

Установить node js

```d
% docker pull node
```
Войти в интерактивную версию node и выйти из нее
```d
% docker run -it node
> .exit
```

## Базовые команды Docker

Просмотреть images

```d
% docker images
```

Посмотреть только те контейнеры, которые сейчас запущены

```d
% docker ps
```

Посмотреть все существующие контейнеры
```d
% docker ps -a
```

##### УДАЛЕНИЕ CONTAINER & IMAGE

Удалить только оставновленные CONTAINER

```d
% docker container prune
```

Удалить только не используемые IMAGE

```d
% docker image prune
```

Удалить CONTAINER
```d
% docker rm [CONTAINER ID] [CONTAINER ID] [CONTAINER ID]
```

Удалить IMAGE
```d
% docker --rmi [IMAGE ID] [IMAGE ID] [IMAGE ID]
```

##Dockerfile 
#### Управление проектом в Docker


1. Добавить в корневую директорию ```Dockerfile``` - добавить инструкции

- Dockerfile
```d
FROM node  // Docker будет искать локально image и если его нет то тогда он скачает его из Docker Hub

WORKDIR /app // это контекст, где будут лежать наши папки

COPY package.json /app

RUN npm install         // % npm i

COPY . . // 1 точка это означает, обращение к корню проекта 2 точка положить в корень (/app)


ENV PORT 4200

EXPOSE $PORT             // какой порт выставить наружу

CMD ["node", "app.js"]  // % node app.js

```

2. Постороение своего образа

```d
logs-app% docker build .
```

3. Посмотреть образ

```d
logs-app% docker images
```

4. Запуск образа в контейнере

```d
logs-app% docker run [IMAGE ID]
```

5. Остановка работы контейнера

```d
logs-app% docker stop [CONTAINER ID]
```

6. Заново запустить 

```d
logs-app% docker start [CONTAINER ID]
```

## Docker RUN CONTAINER

- Указать PORT локальный : внутренний 
```d
logs-app% docker run -p 3000:8000 [IMAGE ID]
```

- Не погружаться в Docker console
```d
logs-app% docker run -d [IMAGE ID]
```

- Подключиться к запущеному Docker CONTAINER

```d
logs-app% docker attach [CONTAINER ID]
```

- Посмотреть логи CONTAINER ID

```d
logs-app% docker logs [CONTAINER ID]
```

- Задать свое имя CONTAINER
```d
logs-app% docker run -name logsapp [IMAGE ID]
```

- Удалить CONTAINER после его остановки 
```d
logs-app% docker run --rm [IMAGE ID]
```
## Docker BUILD IMAGE

- Задать имя logsapp для будущего IMAGE 
```d
logs-app% docker build -t logsapp .
```

- Задать версию для будущего IMAGE с именем logsapp
```d
logs-app% docker build -t logsapp:exc .
```

- Переименовать REPOSITORY для существующего IMAGE
```d
logs-app% docker tag [IMAGE ID] user/newtag
```

- Push REPOSITORY в Docker hub
```d
logs-app% docker push user/newtag
```

- Pull REPOSITORY из Docker hub
```d
logs-app% docker pull user/newtag
```

#### Команды в связке
```d

// Запустить logsapp контейнер и удалить после его остановки
// На порту 80 внешнем и внутреннем 3000
// Обойти погружение в console
% docker run -d -p 80:3000 --name logsapp --rm [IMAGE ID]


// + 
// запуск с определенной версией IMAGE 
// logsapp:exc
% docker run -d -p 80:3000 --name logsapp --rm logsapp:exc
```


## Создание .dockerignore 

Файл в общем виде 

- .dockerignore
```d
.git
Dockerfile
.dockerignore
node_modules
npm-debug.log
README.md
.next
```


## .env переменные 
1. Способ. Задать env в cmd с помощью ```-e```
```d 
% docker run -d -p 3000:80 -e PORT=80
```

2. Способ. Подключение внешнего .env файла
- config/.env 

```d 
PORT=4200
```

Обратимся к внешнему файлу ```--env-file```

```d 
% docker -d -p 80:4200 --env-file ./config/.env
```

##Makefile

Позволяет не писать каждый раз команды в cmd, а просто запускает scripts

Установить ```make``` на  windows или OS     

- Makefile

```d
run: 
    docker run -d -p 80:3000 --name logsapp --rm logsapp:exc
stop: 
    docker stop [CONTAINER ID или название]
```
