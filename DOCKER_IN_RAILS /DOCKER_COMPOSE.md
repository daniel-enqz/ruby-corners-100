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
- `“docker-compose up -d”
