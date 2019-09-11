docker build -t ibaranga/multi-client:latest -t ibaranga/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t ibaranga/multi-server:latest -t ibaranga/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t ibaranga/multi-worker:latest -t ibaranga/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push ibaranga/multi-client:latest
docker push ibaranga/multi-client:$GIT_SHA

docker push ibaranga/multi-server:latest
docker push ibaranga/multi-server:$GIT_SHA

docker push ibaranga/multi-worker:latest
docker push ibaranga/multi-worker:$GIT_SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=ibaranga/multi-client:$GIT_SHA
kubectl set image deployments/server-deployment server=ibaranga/multi-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=ibaranga/multi-worker:$GIT_SHA
