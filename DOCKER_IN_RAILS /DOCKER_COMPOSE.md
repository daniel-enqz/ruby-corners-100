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

## Some usefull commands
1. We can start the containers in detached mode by specifying the -d option. This launches the application in the background and returns you to the shell prompt.
- `docker-compose up -d`

2. Starting and Stopping Services
![Screenshot 2023-05-29 at 9 36 34](https://github.com/daniel-enqz/ruby-corners-100/assets/72522628/664a75bb-041c-4d98-8f87-e6fd978fb1b0)

3. Listing running containers
- `docker-compose ps`
![Screenshot 2023-05-29 at 9 39 05](https://github.com/daniel-enqz/ruby-corners-100/assets/72522628/4e1e6ffb-7022-460c-b61a-63db05234c36)
