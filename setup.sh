az provider register --namespace 'microsoft.insights'

# Create an AKS cluster with ACR integration.

az aks create -n velanscluster -g velansdemo --generate-ssh-keys --attach-acr velansecr \
 --node-count 1 \
 --node-vm-size Standard_B2s \
 --node-osdisk-size 30 \
 --nodepool-name webapps \
 --enable-addons monitoring \
 --enable-cluster-autoscaler \
 --min-count 1 \
 --max-count 2 \
 --node-count 1 \
 --enable-addons open-service-mesh

#Enable open service mesh
az aks enable-addons \
 --resource-group velansdemo \
 --name velanscluster \
 --addons open-service-mesh
# Attach using acr-name
az aks update -n velanscluster -g velansdemo --attach-acr velansecr

az aks get-credentials --resource-group velansdemo --name velanscluster
