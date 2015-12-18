Full Spark-Cassandra Environment on Docker
===================

This is all you'd need to run a full fledged Spark/Cassandra cluster on docker.

TL;DR: Download Docker toolbox, setup a 4GB RAM docker-machine, open some ports, do ```$ docker-compose up -d```.

## Docker toolbox
https://www.docker.com/docker-toolbox -> download and install

## Test docker is running
docker run -it supertest2014/nyan

## Create host VM
docker-machine create --driver virtualbox --virtualbox-memory 4096 dockerhost

## Open ports from dockerhost to localhost
VBoxManage modifyvm "dockerhost" --natpf1 "sparkui,tcp,,4040,,4040"
VBoxManage modifyvm "dockerhost" --natpf1 "sparkdriver,tcp,,7001,,7001"
VBoxManage modifyvm "dockerhost" --natpf1 "sparkfileserver,tcp,,7002,,7002"
VBoxManage modifyvm "dockerhost" --natpf1 "sparkbroadcast,tcp,,7003,,7003"
VBoxManage modifyvm "dockerhost" --natpf1 "sparkreplClassServer,tcp,,7004,,7004"
VBoxManage modifyvm "dockerhost" --natpf1 "sparkblockManager,tcp,,7005,,7005"
VBoxManage modifyvm "dockerhost" --natpf1 "sparkexecutor,tcp,,7006,,7006"
VBoxManage modifyvm "dockerhost" --natpf1 "sparkmaster,tcp,,7077,,7077"
VBoxManage modifyvm "dockerhost" --natpf1 "sparkmasterui,tcp,,8080,,8080"
VBoxManage modifyvm "dockerhost" --natpf1 "sparkworkerui,tcp,,8081,,8081"
VBoxManage modifyvm "dockerhost" --natpf1 "sparkworker,tcp,,8888,,8888"

VBoxManage modifyvm "dockerhost" --natpf1 "cassandraintranode,tcp,,7000,,7000"
VBoxManage modifyvm "dockerhost" --natpf1 "cassandrajmx,tcp,,7199,,7199"
VBoxManage modifyvm "dockerhost" --natpf1 "cassandracql,tcp,,9042,,9042"
VBoxManage modifyvm "dockerhost" --natpf1 "cassandrathrift,tcp,,9160,,9160"

## Optional: Hosts configuration so you can reference dockerhost from your local
echo "$(docker-machine ip dockerhost)" dockerhost | sudo tee -a /etc/hosts
echo "$(docker-machine ip dockerhost)" sparkmaster | sudo tee -a /etc/hosts
echo "$(docker-machine ip dockerhost)" kafkahost | sudo tee -a /etc/hosts

## Optional: Setup OpsCenter (Cassandra Monitoring)
http://dockerhost:8888
Select "Add existing cluster..."
Type cassandra and Save
Start monitoring!

## Optional: Open Spark Console (Spark Monitoring)
http://sparkmaster:8080/


# Utils

# Docker set env, add to ~/.profile and just swap between docker envs. 
```
docker-host() {
    eval "$(docker-machine env $1)"
}
```

Swap docker:
```$ docker-host <machine name>```

# Remove all containers (force):
docker rm -f $(docker ps -a -q)

# Remove all images (force):
docker rmi -f $(docker images -a -q)

# Remove untagged images:
docker rmi $(docker images | grep "^<none>" | awk "{print $3}")

# IP of container
docker inspect --format '{{ .NetworkSettings.IPAddress }}' <container-name>
