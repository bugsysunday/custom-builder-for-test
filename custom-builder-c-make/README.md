custom-builder-c-make
=============

custom-builder-c-make is sample custom builder to build c application on OpenShift v3.

Quick start
---

Just run

~~~
oc create -f https://raw.githubusercontent.com/nak3/custom-builder-for-test/master/custom-builder-c-make/assets/hell-c.json
~~~

Usage
---

Please use from https://hub.docker.com/r/nak3/custom-builder-c-make/

~~~
docker pull nak3/custom-builder-c-make
~~~

(Optional) Build & Push
---

* build 

~~~
docker build -t docker.io/<YOUR_DOCKERHUB_ACT>/custom-builder-c-make .
~~~

eg.
~~~ 
docker build -t docker.io/nak3/custom-builder-c-make .
~~~

* push

~~~
docker login
docker push docker.io/<YOUR_DOCKERHUB_ACT>/custom-builder-c-make
~~~

eg.
~~~
docker push docker.io/nak3/custom-builder-c-make
~~~
