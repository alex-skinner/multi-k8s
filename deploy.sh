docker build -t alexskinner/multi-client:latest -t alexskinner/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t alexskinner/multi-server:latest -t alexskinner/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t alexskinner/multi-worker:latest -t alexskinner/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push alexskinner/multi-client:latest
docker push alexskinner/multi-server:latest
docker push alexskinner/multi-worker:latest

docker push alexskinner/multi-client:$SHA
docker push alexskinner/multi-server:$SHA
docker push alexskinner/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=alexskinner/multi-client:$SHA
kubectl set image deployments/server-deployment server=alexskinner/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=alexskinner/multi-worker:$SHA