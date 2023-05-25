# Fine Tuning Images

### Running a specific command 
Adding a new instruction to our Dockerfile. The CMD instruction, pronounced“command,” specifies the default command to run when a container is started from the image.


```bash
“​FROM​​ ruby:2.6​​ ​ ​RUN ​apt-get update -yqq​ ​RUN ​apt-get install -yqq --no-install-recommends nodejs​ ​ ​COPY​​ . /usr/src/app/​​ ​ ​WORKDIR​​ /usr/src/app​​ ​RUN ​bundle install​ »​CMD​​ ["bin/rails", "s", "-b", "0.0.0.0"]​”
```
