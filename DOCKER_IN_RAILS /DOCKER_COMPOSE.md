# What is Docker Compose? 

```bash
# docker-compose.yml
version: "3"

services:
  web:
    build: .
    ports:
      - "3000:3000"
    volumes:
      - .:/usr/src/app
```

1. Is a tool for managing an application that needs several different containers to work together.
2. It also manages creating and destroying the resources needed for the app.

# Why volumes?
> “A mounted local volume represents some filesystem that’s shared between your local machine and the
container. Files in the mounted volume are synced both ways between your local filesystem and the
container.”


## Some usefull commands
1. We can start the containers in detached mode by specifying the -d option. This launches the application in the background and returns you to the shell prompt.
- `docker-compose up -d`

2. Starting and Stopping Services `docker-compose [start|stop|kill|restart|pause|unpause|rm] service name>`
![Screenshot 2023-05-29 at 9 36 34](https://github.com/daniel-enqz/ruby-corners-100/assets/72522628/664a75bb-041c-4d98-8f87-e6fd978fb1b0)

3. Listing running containers `docker-compose ps`
![Screenshot 2023-05-29 at 9 39 05](https://github.com/daniel-enqz/ruby-corners-100/assets/72522628/4e1e6ffb-7022-460c-b61a-63db05234c36)

4. Viewing the Container Logs `docker-compose logs -f web` 

5. Ruuning commands
- In a new, throwaway container `docker-compose run --rm <service name> <some command>`
- Open an interactive terminal to debug with: `docker-compose run --service-ports web`
- Run a one-off command in an existing container `docker-compose exec <service name> <some command>`

6. Rebuilding images (Needed when you modify gemfile, dockerfile or add other dependecies)
- `docker-compose build web`

7. Cleaning
- A single container `docker-compose rm`
- All containers `docker container prune`
- All images `docker image prune`
- Free up all resources `docker system prune`

8. Starting a service again, and recreating it: `docker-compose up -d --force-recreate web`

9. STARTING OUR WHOLE APP (ALL SERVICES)
- `docker-compose up`
