# Dockerfiles

A Dockerfile uses special syntax to describe exactly how the image should be constructed.
- Dockerfile is made up of various instructions—such as FROM, RUN, COPY, and WORKDIR

## Basic Dockerfile for a Rails app:

Every image has to start from something: another, preexisting image. For that reason, every
Dockerfile begins with a FROM instruction, which specifies the image to use as its starting
point.

1. The -yqq option is a combination of the -y option, which says to answer “yes” to any prompts, and the -qq option, which enables “quiet” mode to reduce the printed output.
2. apt-get install command installs Node.js, a prerequisite for running Rails. The --no-install-recommends says not to install other recommended but nonessential packages.
3. Any changes made to files or directories within /usr/src/app inside the container will be reflected in your local working directory, and vice versa.

```
# Dockerfile / Run this with "docker build ."
FROM ruby:2.6 

RUN apt-get update -yqq                                 
RUN apt-get install -yqq --no-install-recommends nodejs 

COPY . /usr/src/app/  # copy files or directories from the host machine (your local system) into the Docker image.                               
WORKDIR /usr/src/app  # make this the current working directory for the image (line 8) so that we can execute Rails commands against the image from the correct directory.                                       
RUN bundle install
```
This will generate images step by step, after each step it will delete that image. The very last image will be the one after all steps are completd.
- With `docker images` we will see the following output:

“The first entry is the custom image that at the end of the docker build command.”

![Screenshot 2023-05-25 at 10 01 12](https://github.com/daniel-enqz/ruby-corners-100/assets/72522628/e3a572e7-5a18-4369-bb2f-3553ebf58544)

Finally we can run a command inside our created container using our image ID:

```bash
docker run -p 3000:3000 a1df0eddba18 bin/rails s -b 0.0.0.0
```


---

# Docker architecture
![Screenshot 2023-05-24 at 15 21 57](https://github.com/daniel-enqz/ruby-corners-100/assets/72522628/b885eedc-b4d9-4189-a404-79b4fc3a300e)


