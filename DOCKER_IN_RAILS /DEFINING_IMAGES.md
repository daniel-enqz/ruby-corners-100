# Dockerfiles

A Dockerfile uses special syntax to describe exactly how the image should be constructed.
- Dockerfile is made up of various instructions—such as FROM, RUN, COPY, and WORKDIR

## Basic Dockerfile for a Rails app:

Every image has to start from something: another, preexisting image. For that reason, every
Dockerfile begins with a FROM instruction, which specifies the image to use as its starting
point.
```
FROM ruby:2.6 

RUN apt-get update -yqq                                 
RUN apt-get install -yqq --no-install-recommends nodejs 

COPY . /usr/src/app/                                    
WORKDIR /usr/src/app                                    

RUN bundle install




![Screenshot 2023-05-24 at 15 21 57](https://github.com/daniel-enqz/ruby-corners-100/assets/72522628/b885eedc-b4d9-4189-a404-79b4fc3a300e)
