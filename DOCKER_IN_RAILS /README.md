# USING DOCKER IN RAILS

## Docker? 🐳
“Is a set of tools built around the idea of packaging and running software in small, sandboxed environments known as containers”

### What we can achieve with docker?
Essentialy we can create precise ecosystems for our development.

- *Packaging* The ability to package software into a reusable, shareable format known as
images.

- *Distribution* The ability to easily share packaged software (images) with other people and
deploy it to different machines.

- Runtime. The ability to run, pause, restart, or stop packaged software in a reliable,
repeatable way.

- *Infrastructure creation* Creating virtual machines ready to run our Docker containers.

- *Orchestration and scaling* Managing the release of software to a single Docker node or
across an entire cluster.

## Container and Images
“People have also likened images to an abstract class in programming, and containers to instances of
that class.”

### Container
Simply put, a container is another process on your machine that has been isolated from all other processes on the host machine.

# Running first commands:
This command starts a new container based on <image>.
  
`docker run [OPTIONS] <image>`


### Image
When running a container, it uses an isolated filesystem. This custom filesystem is provided by a container image. Since the image contains the container's filesystem, it must include everything needed to run the application - all dependencies, configuration, scripts, binaries, etc. The image also contains other configuration for the container, such as environment variables, a default command to run, and other metadata.

“docker run [OPTIONS] <image <command>”
![Screenshot 2023-05-24 at 10 41 48](https://github.com/daniel-enqz/ruby-corners-100/assets/72522628/c97a8abd-c6e2-4dca-aacb-f80771e854d2)

![Screenshot 2023-05-24 at 12 08 18](https://github.com/daniel-enqz/ruby-corners-100/assets/72522628/a547a5c4-f934-4948-9f5a-c150d43472c4)