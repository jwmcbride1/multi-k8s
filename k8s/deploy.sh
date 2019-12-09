docker build -t jwmcbride1/multi-client:latest -f -t jwmcbride1/multi-client:$SHA ./client/Dockerfile ./client
docker build -t jwmcbride1/multi-server:latest -t jwmcbride1/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jwmcbride1/multi-worker:latest -t jwmcbride1/multi-worker:$SHA -f ./worker/Dokcerfile ./worker
docker push jwmcbride1/multi-client:latest
docker push jwmcbride1/multi-server:latest
docker push jwmcbride1/multi-worker:latest
docker push jwmcbride1/multi-client:$SHA
docker push jwmcbride1/multi-server:$SHA
docker push jwmcbride1/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jwmcbride1/multi-server:$SHA
kubectl set image deployments/client-deployment client=jwmcbride1/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jwmcbride1/multi-worker:$SHA