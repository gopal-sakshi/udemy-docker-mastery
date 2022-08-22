#! /bin/sh


# we are creating two networks... 
    # overlay network = only kind of network we use in swarm... 
    # becoz overlay allows us to span across nodes as if they're all on same network
    # the names of networks = backend & frontend
docker network create -d overlay backend
docker network create -d overlay frontend
# there is nothing inherently special about these two networks
    # we are just going to segment our different services into one or the other
    # to help act as firewall

# service1
    # name = vote
    # we expose port 80 (or) 4001
    # we use 2 containers for this...
    # the image we use = bretfisher/examplevotingapp_vote
    # we use frontend network
# docker service create --name vote -p 80:80 --network frontend --replicas 2 bretfisher/examplevotingapp_vote
docker service create --name vote -p 4001:80 --network frontend --replicas 2 bretfisher/examplevotingapp_vote

docker service create --name redis --network frontend redis:3.2

docker service create --name db --network backend -e POSTGRES_HOST_AUTH_METHOD=trust --mount type=volume,source=db-data,target=/var/lib/postgresql/data postgres:9.4


# service4
    # name = worker
    # this service = exists on both frontend & backend network
docker service create --name worker --network frontend --network backend bretfisher/examplevotingapp_worker

# service5
    # name = result... this image uses websockets
    # websockets = there can only 1 container
    # because, websockets need persistent connection... so, we cant switch between containers
    # but if you need, you need to add a proxy infront of this service5 ???
    # anyway for the time being, its only 1 container
docker service create --name result --network backend -p 5001:80 bretfisher/examplevotingapp_result


# do this
    # http://143.110.179.229:4001/
    # http://143.110.179.229:5001/