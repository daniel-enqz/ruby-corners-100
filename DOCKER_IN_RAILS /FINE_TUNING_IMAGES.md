# Fine Tuning Images

### Adding our label, signature 😎 to our dockerfile(image)
```bash
LABEL maintainer="Daniel Enqz < daniel.enm17@gmail.com"
```

### Running a specific command 
Adding a new instruction to our Dockerfile. The CMD instruction, pronounced“command,” specifies the default command to run when a container is started from the image.

```bash
FROM ruby:2.6 

LABEL maintainer="Daniel Enqz < daniel.enm17@gmail.com"

RUN apt-get update -yqq                                 
RUN apt-get install -yqq --no-install-recommends nodejs 

COPY . /usr/src/app/  # copy files or directories from the host machine (your local system) into the Docker image.                               
WORKDIR /usr/src/app  # make this the current working directory for the image (line 8) so that we can execute Rails commands against the image from the correct directory.                                       
RUN bundle install
CMD ["bin/rails", "s", "-b", "0.0.0.0"]
```

Of course we will need to rebuild this image, in order to create a new container:
`docker build -t railsapp .`

You can allways overide CMD in dockerfile by sending a command like:
`docker run --rm railsapp bin/rails -T` 

# Problems with Caching.

> Remember you can an `.dockerignore` file to ignore files like .git, node_modules, etc. Thos will not be send when building the image.

When rebuilding an image, we can encounter the problem where only by changing a line in README.md for example it will end up installing our gems again, 
becasue that step is bellow `COPY . /usr/src/app/`, so it will stop usuing caching from that line below.
Fix it like this:
```bash
FROM ruby:2.6 

LABEL maintainer="Daniel Enqz < daniel.enm17@gmail.com"

RUN apt-get update -yqq                                 
RUN apt-get install -yqq --no-install-recommends nodejs 

COPY Gemfile* /usr/src/app/ # This creates a separate, independent layer. Docker’s cache for this layer will only be busted if either of these two files change.           
WORKDIR /usr/src/app                  
RUN bundle install

COPY . /usr/src/app/ # Now, changes to all remaining files copied in this step will only bust the cache at this instruction, which is after our gems have been installed—just what we want.

CMD ["bin/rails", "s", "-b", "0.0.0.0"]
```
     
