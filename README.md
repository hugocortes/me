# me

simple static portfolio site using [Hugo Framework](https://gohugo.io/)

# Running

This site is best ran as a docker container and the image can be found in my [docker hub](https://hub.docker.com/r/hugocortes/)

Step to use public image (use latest for x86 and arm32v6 for RPi):
1. `docker run -d -e BASE_URL=http://localhost -e APPEND_PORT=true --name me -p 1313:1313 hugocortes/me:latest`

Steps to build locally:
1. `docker build -t <IMAGE_NAME> .`
2. `docker run -d --name me -p 1313:1313 <IMAGE_NAME>`
