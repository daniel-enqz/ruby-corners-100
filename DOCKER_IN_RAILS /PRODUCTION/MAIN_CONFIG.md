# Running software in production

Running software in production. We can break this down into a number of different areas:
1. Provisioning
2. Configuration management
3. Release management
4. Monitoring 
5. Operating.

# What is orchestation in docker
- Container orchestrators provide a platform for running and managing containerized applications, abstracting away low-level server details and automating tasks like container restarts and node failure recovery.
- Orchestrators enable smarter and resilient operations by understanding the desired state of the system, facilitating rolling updates, achieving zero-downtime deployments, and securely managing cluster state and communication.


## Cluster
> A cluster, in the context of computing, refers to a group of interconnected computers or servers that work together as a unified system. These computers, often referred to as nodes, collaborate to achieve a common goal, such as running applications, processing data, or providing services.

>  The cluster can be composed of physical machines, virtual machines (VMs), or a combination of both.

# Kubernates vs Swarm
![Screenshot 2023-06-04 at 20 08 01](https://github.com/daniel-enqz/ruby-corners-100/assets/72522628/2c13164b-bd8d-4e89-a4ce-a5b9345a170f)

## IaaS vs CaaS

> IaaS provides virtualized infrastructure resources, while CaaS focuses specifically on containerization technologies and provides a platform to run and manage containers efficiently.

### What to choose?

- Upfront cost vs. long-term cost.
- Focus and developer bandwidth. 
- Support and maintenance costs.
- Control and flexibility.
- Regional availability.
- Level of expertise required vs. ability of team.
- Vendor/platform lock-in.

---

### Pushing our app to Docker Hub.
1. Be sure to create a separte file `.env`

```bash
# .env/production/database
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres-production
POSTGRES_DB=myapp_production
```
```bash
# .env/production/web
DATABASE_HOST=database
RAILS_ENV=production
SECRET_KEY_BASE=5dc3229a37d70549bcd163b05e184fbaa20579bc552191e35a51d3682722667531b5306202bbefb7abed4fb6dc75c7f1026fe745c9beb5cfac1dfc876dd161e4
RAILS_LOG_TO_STDOUT=true
RAILS_SERVE_STATIC_FILES=true
```
2. Create a new COPY of Dockerfile and as assets will not be served in each request and instead be chached, we need to add this line:
```bash
# Dockerfile.prod
[...]
RUN bin/rails assets:precompile

ENTRYPOINT ["./docker/docker-entrypoint.sh"]
CMD ["bin/rails", "s", "-b", "0.0.0.0"]
[...]
```
3. Push app to Docker Hub: `docker build -f Dockerfile.prod -t danielenqz/myapp_web:prod .`
  - Naming convention `[<registry hostname>[:port]/]<username>/<image name>[:<tag>]`
  - We can now have images in multiple machines.

In fact, there are lots of options when it comes to sharing your images, depending on your requirements. Docker Hub is only one of several hosted registries available. Other options include:

- Amazon Elastic Container Registry
- Google Cloud Container Registry
- Microsoft Azure Container Registry
- Quay
