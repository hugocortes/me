# me

simple static portfolio site using [Hugo Framework](https://gohugo.io/)

## local

Use [hugo server](https://gohugo.io/commands/hugo_server/) to run this locally

```sh
# when cloning, get submodule
git clone --recurse-submodules git@github.com:hugocortes/me.git

# or
git submodule init
git submodule update

# now run (defaults to port 1313)
hugo server --bind=0.0.0.0
```

## building

By default this site's baseUrl is bound to `https://hugocortes.dev`, if you would like to point it to a different baseUrl, you will have to use provide `baseURL` as a build arg when building docker image:
```sh
docker build --build-arg baseURL=http://localhost:1313 -t hugocortes/me:latest .
```

This will fetch static resources from `http://localhost:1313` after the image is ran

## deployment

When doing a deploy, a docker image is used to serve the site using [nginx](https://hub.docker.com/_/nginx/).

```sh
docker run -d --name me -p 80:80 hugocortes/me
```