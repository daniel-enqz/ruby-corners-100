# Adding services

### Quick reminder about `ports`
- In Docker, when you define port mappings using the ports directive, you are specifying how network traffic should be forwarded between the host machine and the containers.
- These additional ports mappings allow you to access different services running inside their respective containers from the host machine or other devices on the network. 

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
      - .:/usr/src/app
      - gem_cache:/gems
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
      - db_data:var/lib/postgresql/data
  
  volumes:
    db_data:
```

### ‼️ Important: Persisting data

- We cannot rely on saving data in the same database container, therefore we will use volumes, if we stop our database container with a connected volume, the volume will still exist independently. 

```
docker volume inspect --format '{{ .Mountpoint }}' myapp_db_data
#OUTPUT => /var/lib/docker/volumes/myapp_db_data/_data
```
### What is that output?

The mountpoint path /var/lib/docker/volumes/myapp_db_data/data is the location where the data associated with the Docker volume myapp_db_data is stored on the host machine. When you use a Docker volume to persist data, it is stored in this location, allowing it to be accessed and reused by containers even after they are restarted or recreated.

# Why volumes?
> “A mounted local volume represents some filesystem that’s shared between your local machine and the
container. Files in the mounted volume are synced both ways between your local filesystem and the
container.”

- We are also setting a volume for our gems cache, so now theres no need to reinstall all gems when rebuilding our image as it will use the volume.

