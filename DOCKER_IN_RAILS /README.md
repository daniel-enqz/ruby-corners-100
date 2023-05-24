# USING DOCKER IN RAILS

## Docker? 🐳
“Is a set of tools built around the idea of packaging and running software in small, sandboxed environments known as containers”

Excerpt From
Docker for Rails Developers (for Den Patin)
Rob Isenberg
https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewBook?id=0
This material may be protected by copyright.

Excerpt From
Docker for Rails Developers (for Den Patin)
Rob Isenberg
https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewBook?id=0
This material may be protected by copyright.

### Container
Simply put, a container is another process on your machine that has been isolated from all other processes on the host machine.

### Image
When running a container, it uses an isolated filesystem. This custom filesystem is provided by a container image. Since the image contains the container's filesystem, it must include everything needed to run the application - all dependencies, configuration, scripts, binaries, etc. The image also contains other configuration for the container, such as environment variables, a default command to run, and other metadata.

“docker run [OPTIONS] <image <command>”
![Screenshot 2023-05-24 at 10 41 48](https://github.com/daniel-enqz/ruby-corners-100/assets/72522628/c97a8abd-c6e2-4dca-aacb-f80771e854d2)

![Screenshot 2023-05-24 at 12 08 18](https://github.com/daniel-enqz/ruby-corners-100/assets/72522628/a547a5c4-f934-4948-9f5a-c150d43472c4)
