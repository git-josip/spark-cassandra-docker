To build:
```
sbt -Dscala-2.11=true docker:publishLocal
```

To run (after docker-compose up of the cluster):
```
docker run -it --link sparkmaster:sparkmaster --link sparkcassandradocker_cassandra_1:cassandra sbt-docker-example:1.0\
```