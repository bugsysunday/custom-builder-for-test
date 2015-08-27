custom-builder-gitclone
=============

This custome builder image is just for git clone test.

Usage
---

Please use from https://hub.docker.com/r/nak3/custom-builder-gitclone/

~~~
docker pull nak3/custom-builder-gitclone
~~~

(Optional) Build & Push
---

* build 

~~~
docker build -t docker.io/<YOUR_DOCKERHUB_ACT>/custom-builder-gitclone .
~~~

eg.
~~~ 
docker build -t docker.io/nak3/custom-builder-gitclone .
~~~

* push

~~~
docker login
docker push docker.io/<YOUR_DOCKERHUB_ACT>/custom-builder-gitclone
~~~

eg.
~~~
docker push docker.io/nak3/custom-builder-gitclone
~~~
