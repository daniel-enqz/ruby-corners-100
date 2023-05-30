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

Running a separetly container:
`docker-compose run --rm database psql -U postgres -h database` 
