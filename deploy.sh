# Build images
docker build -t tomromanowski7/multi-client:latest -t tomromanowski7/multi-client:"$SHA" -f ./client/Dockerfile ./client
docker build -t tomromanowski7/multi-server:latest -t tomromanowski7/multi-server:"$SHA" -f ./server/Dockerfile ./server
docker build -t tomromanowski7/multi-worker:latest -t tomromanowski7/multi-worker:"$SHA" -f ./worker/Dockerfile ./worker

# Push images
docker push tomromanowski7/multi-client:latest
docker push tomromanowski7/multi-client:"$SHA"
docker push tomromanowski7/multi-server:latest
docker push tomromanowski7/multi-server:"$SHA"
docker push tomromanowski7/multi-worker:latest
docker push tomromanowski7/multi-worker:"$SHA"

# Apply kubernetes configs
kubectl apply -f k8s

# Update images
kubectl set image deployments/client-deployment client=tomromanowski7/multi-client:"$SHA"
kubectl set image deployments/server-deployment server=tomromanowski7/multi-server:"$SHA"
kubectl set image deployments/worker-deployment worker=tomromanowski7/multi-worker:"$SHA"
