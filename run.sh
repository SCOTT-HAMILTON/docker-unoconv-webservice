#!/bin/sh

cd /home/pi/docker-unoconv-webservice
sudo docker run -d -p 80:3000 --rm --name unoconv docker-unoconv-webservice
