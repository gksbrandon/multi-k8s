docker build -t gksbrandon/multi-client:latest -t gksbrandon/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t gksbrandon/multi-server:latest -t gksbrandon/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t gksbrandon/multi-worker:latest -t gksbrandon/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push gksbrandon/multi-client:latest
docker push gksbrandon/multi-server:latest
docker push gksbrandon/multi-worker:latest

docker push gksbrandon/multi-client:$SHA
docker push gksbrandon/multi-server:$SHA
docker push gksbrandon/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=gksbrandon/multi-client:$SHA
kubectl set image deployments/server-deployment server=gksbrandon/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=gksbrandon/multi-worker:$SHA