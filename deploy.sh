docker build -t 160492/client:latest -t 160492/client:$SHA -f ./client/Dockerfile ./client
docker build -t 160492/server:latest -t 160492/server:$SHA-f ./server/Dockerfile ./server
docker build -t 160492/worker:latest -t 160492/worker:$SHA -f ./worker/Dockerfile ./worker

docker push 160492/client:latest
docker push 160492/client:$SHA

docker push 160492/server:latest
docker push 160492/server:$SHA

docker push 160492/worker:latest
docker push 160492/worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=160492/server:$SHA
kubectl set image deployments/client-deployment client=160492/client:$SHA
kubectl set image deployments/worker-deployment worker=160492/worker:$SHA
