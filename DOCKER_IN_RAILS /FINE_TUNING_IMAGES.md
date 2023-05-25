# Fine Tuning Images

### Running a specific command 
Adding a new instruction to our Dockerfile. The CMD instruction, pronounced“command,” specifies the default command to run when a container is started from the image.

```bash
FROM ruby:2.6 

RUN apt-get update -yqq                                 
RUN apt-get install -yqq --no-install-recommends nodejs 

COPY . /usr/src/app/  # copy files or directories from the host machine (your local system) into the Docker image.                               
WORKDIR /usr/src/app  # make this the current working directory for the image (line 8) so that we can execute Rails commands against the image from the correct directory.                                       
RUN bundle install
CMD ["bin/rails", "s", "-b", "0.0.0.0"]
```

Of course we will need to rebuild this image, in order to create a new container:
`docker build -t railsapp .`

You can allways ran more commands like the next one:
`docker run --rm railsapp bin/rails -T` 

Note the use of --rm to delete the container after it runs. We used it here and not when running
the Rails server, because this container has served its purpose after it has generated the Rake task
output, whereas a container to run the Rails server can be reused.
