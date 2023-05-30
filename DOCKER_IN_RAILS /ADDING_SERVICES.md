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


In order to connect to the service, we can do:
`docker-compose run --rm database psql -U postgres -h database` 

```ruby
version: "3"

services:
  web:
    build: .
    ports:
      - "3000:3000"
    volumes:
      - .:/usr/src/app # line 10
    env_file:
      - .env/development/database
      - .env/development/web

  redis:
    image: redis

  database:
    image: postgres
    env_file:
      - .env/development/database
    volumes:
      - db_data:var/lib/postgresql/data # line 23
  
  volumes:
    db_data:
```

### ‼️ Important: Persisting data

Mounting a named volume (line 23) is similar to mounting a local directory (line 10)—the difference is that the part before
the colon refers to the name of the named volume rather than a local path. Here (line 23) we’re saying, “Mount the db_data named
volume at /var/lib/postgresql/data”—the directory where the Postgres image stores its
database files that we want to persist.”

This command will output the mountpoint path of the specified volume. In this case, it will display /var/lib/docker/volumes/myapp_db_data/_data as the mountpoint for the myapp_db_data volume.
`docker volume inspect --format '{{ .Mountpoint }}' myapp_db_data`

