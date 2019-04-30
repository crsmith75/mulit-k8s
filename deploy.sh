docker build -t csmith75/multi-client:latest -t csmith75/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t csmith75/multi-server:latest -t csmith75/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t csmith75/multi-worker:latest -t csmith75/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push csmith75/multi-client:latest
docker push csmith75/multi-server:latest
docker push csmith75/multi-worker:latest

docker push csmith75/multi-client:$SHA
docker push csmith75/multi-server:$SHA
docker push csmith75/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=csmith75/multi-server:$SHA
kubectl set image deployments/client-deployment client=csmith75/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=csmith75/multi-worker:$SHA
