# Running first commands:

- `docker ps:` lists current running containers
- `docker ps -a:` lists all stopped containers
- `docker images:` lists all images

This command starts a new container based on an image.
  
`docker run [OPTIONS] <image>`
<br>
![Screenshot 2023-05-24 at 10 41 48](https://github.com/daniel-enqz/ruby-corners-100/assets/72522628/c97a8abd-c6e2-4dca-aacb-f80771e854d2)


# Interacting with containers:
“We can start a container running an interactive Bash shell. When we do this, we literally get a terminal session running inside the container.”

`docker run -it --rm -v ${PWD}:/usr/src/app ruby:3.1.0 bash`

1. Specifically, -v ${PWD}:/usr/src/app says, “Mount our current directory inside the container at /usr/src/app”

> On your local machine, when you run the Docker container with the -v ${PWD}:/usr/src/app option, you are mounting your local current working directory (the output of pwd command) to the /usr/src/app directory inside the container. This establishes a connection between the two directories.

2. -it flags helps start an interactive session through a bash terminal and give input to our container.
