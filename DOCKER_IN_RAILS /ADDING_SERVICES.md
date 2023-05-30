# Adding services

## Redis:

Remember we can run a container with a specific predifined image with:
- `docker run --name redis-container redis`

Or we can define our service in `docker-compose.yml`
- `docker-compose up -d redis`

```ruby
version: "3"

services:
  web:
    build: .
    ports:
      - "3000:3000"
    volumes:
      - .:/usr/src/app

  redis:
    image: redis
```

*By running docker-compose up, the defined services will be started and connected within the network, enabling communication between them.*

> When defining a service, there are two ways to specify the image to be used for creating containers.
Our web service uses the build property to instruct Compose to build our custom image from a
Dockerfile. However, to use a preexisting image instead, we can specify the image’s name with
the image property. Here we specify the redis image, just like in our docker run command.

## Postgres:

![Screenshot 2023-05-30 at 12 04 06](https://github.com/daniel-enqz/ruby-corners-100/assets/72522628/2eb8cc61-abb3-4bda-b535-30c4b79b1bc7)

```ruby
version: "3"

services:
  web:
    build: .
    ports:
      - "3000:3000"
    volumes:
      - .:/usr/src/app
    env_file:
      - .env/development/database
      - .env/development/web

  redis:
    image: redis

  database:
    image: postgres
    env_file:
      - .env/development/database
```

In order to connect to the service, we can do:
`docker-compose run --rm database psql -U postgres -h database` 
