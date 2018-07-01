# me

simple static portfolio site using [Hugo Framework](https://gohugo.io/)

# Running

This site is best ran as a docker container and the image can be found in my [docker hub](https://hub.docker.com/r/hugocortes/)

Steps to run public image from docker hub
1. `docker run -d --name me -p 1313:1313 hugocortes/me:latest`

Steps to run locally:
1. `docker build -t <IMAGE_NAME> .`
2. `docker run -d --name me -p 1313:1313 <IMAGE_NAME>`
