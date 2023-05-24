# USING DOCKER IN RAILS

### Container
Simply put, a container is another process on your machine that has been isolated from all other processes on the host machine.

### Image
When running a container, it uses an isolated filesystem. This custom filesystem is provided by a container image. Since the image contains the container's filesystem, it must include everything needed to run the application - all dependencies, configuration, scripts, binaries, etc. The image also contains other configuration for the container, such as environment variables, a default command to run, and other metadata.

“docker run [OPTIONS] <image <command>”
![Screenshot 2023-05-24 at 10 41 48](https://github.com/daniel-enqz/ruby-corners-100/assets/72522628/c97a8abd-c6e2-4dca-aacb-f80771e854d2)
