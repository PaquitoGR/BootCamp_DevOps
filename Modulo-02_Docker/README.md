# lemoncode-challenge
## Ejercicios Bootcamp Devops III - Modulo 2 Docker

### Commandos utilizados ejercicio 1:

  - Crear el contenedor mongo a partir de la imagen de Docker Hub:
  ```bash  
    docker run -d --name some-mongo -p 27017:27017 --mount source=data,target=/data/db --network lemoncode-challenge mongo:latest
  ```
  - Crear la imagen y el contenedor para el frontend:
  ```bash
    docker build -t frontend .
    docker run -d --name frontend -p 8080:3000 -e API_URI=http://topics-api:5000/api/topics --network lemoncode-challenge frontend
  ```
  *Dockerfile:*
  ```Dockerfile
    # ./frontend/Dockerfile
    FROM node:16
    WORKDIR /app
    COPY package*.json ./
    RUN npm install
    COPY . .
    EXPOSE 3000
    CMD ["npm", "start"]
  ```
  - Crear la imagen y el contenedor para el backend:
  ```bash
    docker build -t backend .
    docker run -d --name topics-api --network lemoncode-challenge backend
  ```
  *Dockerfile:*
  ```Dockerfile 
    # ./backend/Dockerfile
    FROM mcr.microsoft.com/dotnet/sdk:3.1
    WORKDIR /app
    COPY . ./
    CMD ["dotnet", "run"]
  ```
### Archivos modificados:

   - ./frontend/server.js - línea 06
  ```js
    const LOCAL = 'http://localhost:5000/api/topics';
    // Cambiada por:
    const LOCAL = 'http://topics-api:5000/api/topics';
  ```
   - ./backend/appsettings.json - línea 03
  ```json
    "ConnectionString": "mongodb://localhost:27017",
    // Cambiada por
    "ConnectionString": "mongodb://some-mongo:27017",
  ```
   - ./backend/Properties/launchSettings.json - líneas 07 y 27
  ```json
    "applicationUrl": "http://localhost:49704",
    "applicationUrl": "http://localhost:5000",
    // Cambiadas por
    "applicationUrl": "http://0.0.0.0:49704",
    "applicationUrl": "http://0.0.0.0:5000",   
  ```
   
### Comandos utilizados ejercicio 2:

  - Levantar infraestructura:
  ```Bash
    docker-compose up
  ```
  - Parar:
  ```Bash
    docker-compose stop
  ```
  - Eliminar:
  ```Bash
    docher-compose down
  ```
 *docker-compose.yml:*      
  ```yml
    # ./docker-compose.yml
    version: "3.9" 
    services:
      some-mongo:
        image: mongo:latest
        volumes:
          - db_data:/data/db
        ports:
          - 27017:27017
        restart: always
        networks: 
          - lemoncode-challenge
      topics-api:
        build:
          context: ./backend
          # dockerfile: Dockerfile
        networks:
          - lemoncode-challenge
        depends_on:
          - some-mongo
        restart: always
      frontend:
        build:
          context: ./frontend
          # dockerfile: Dockerfile
        environment:
          - API_URI=http://topics-api:5000/api/topics
        ports:
          - "8080:3000"
        networks:
          - lemoncode-challenge
        depends_on:
          - topics-api
        restart: always
    volumes:
      db_data: 
    networks:
      lemoncode-challenge: 
  ```
