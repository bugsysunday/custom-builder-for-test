custom-builder-debug
=============

custom-builder-debug is sample custom builder to debug build process on OpenShift v3.

Quick start
---

Just run

~~~
oc create -f https://raw.githubusercontent.com/nak3/custom-builder-for-test/master/custom-builder-debug/assets/ruby-hello-world.json
~~~

Usage
---

Please use from https://hub.docker.com/r/nak3/custom-builder-debug/

~~~
docker pull nak3/custom-builder-debug
~~~

(Optional) Build & Push
---

* build 

~~~
docker build -t docker.io/<YOUR_DOCKERHUB_ACT>/custom-builder-debug .
~~~

eg.
~~~ 
docker build -t docker.io/nak3/custom-builder-debug .
~~~

* push

~~~
docker login
docker push docker.io/<YOUR_DOCKERHUB_ACT>/custom-builder-debug
~~~

eg.
~~~
docker push docker.io/nak3/custom-builder-debug
~~~
