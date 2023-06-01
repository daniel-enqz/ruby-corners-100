# Solving some irritations

## Rails tmp/pids/server.pid Not Cleaned Up

> Define an entrypoint in a bash file that will ensure that any `server.pid` file is left behind.

```bash
#!/bin/sh
set -e # This makes the script fail fast if any subsequent commands terminate with an error (non-zero exit status).

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

exec "$@" # Replace this running Bash script with a Rails server.
```

```bash
ENTRYPOINT ["./docker/docker-entrypoint.sh"]
CMD ["bin/rails", "s", "-b", "0.0.0.0"]
```


## Compose Intermittently Aborts with Ctrl-C

- When starting your app with docker-compose in attached mode, we can exit this gracefully with `Ctrl + C`. 
- Sometimes we will get `^CERROR: Aborting.`
- Solution: `docker-compose up -d` Start the app in detached mode jeje.
