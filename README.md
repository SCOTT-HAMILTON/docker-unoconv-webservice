# docker-unoconv-webservice (alpine)

Fork of [https://github.com/zrrrzzt/docker-unoconv-webservice/](https://github.com/zrrrzzt/docker-unoconv-webservice/) : a Dockerimage to run unoconv as a webservice through [tfk-api-unoconv](https://github.com/zrrrzzt/tfk-api-unoconv).

This makes the docker-unoconv-webservice run an alpine base image which takes far less disk than the ubuntu based one. And this allows to run on raspberrypi (which is why I use it for).

You can use it with the [Unoconv UI](http://github.com/SCOTT-HAMILTON/UnoconvUI) app on Android, Linux and Windows instead of using curl.

## Build

```bash
$ docker build -t docker-unoconv-webservice .
```
or
```bash
$ ./build.sh
```

## Run - example
```bash
$ docker run -d -p 80:3000 --name unoconv docker-unoconv-webservice
```
or
```bash
$ ./run.sh
```

## Usage

Post the file you want to convert to the server and get the converted file in return.

See all possible conversions on the [unoconv website](http://dag.wiee.rs/home-made/unoconv/).

API for the webservice is /unoconv/{format-to-convert-to} so a docx to pdf would be

```bash
$ curl -F file=@myfile.docx http://localhost/unoconv/pdf > myfile.pdf
```

For a basic example with upload via form take a look at the [browser-file-convert](https://github.com/nithinkashyapn/browser-file-convert) example from [nithinkashyapn](https://github.com/nithinkashyapn)

### Formats

To see all possible formats for convertion visit ```/unoconv/formats```

To see formats for a given type ```/unoconv/formats/{document|graphics|presentation|spreadsheet}```

### Versions

To see all versions of unoconv and dependencies lookup ```/unoconv/versions```

### Healthz

Are we alive? ```/healthz```

returns

```JavaScript
{
  uptime: 18.849
}
```

## Environment

You can change the webservice port and filesize-limit by changing environment variables.

SERVER_PORT default is 3000

PAYLOAD_MAX_SIZE default is 1048576 (1 MB)

TIMEOUT_SERVER default is 2 minutes (120 000 milliseconds)

TIMEOUT_SOCKET default is 2 minutes and 20 seconds (140 000 milliseconds)

Change it in the Dockerfile or create an env-file and load it at containerstart

```bash
$ docker run --env-file=docker.env -d -p 80:3000 --name unoconv docker-unoconv-webservice
```

## License
[MIT](LICENSE)
