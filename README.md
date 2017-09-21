## docker-hugo

This image is built on `alpine:latest` and will attempt to stay current. #patcheswelcome

## kubernetes

```yaml
kind: Deployment
apiVersion: apps/v1beta1
metadata:
  name: hugo
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: hugo
    spec:
      containers:
      - name: hugo
        image: gcr.io/kubesec/hugo:latest
        args:
        - /usr/bin/hugo
        - server
        - --bind=0.0.0.0
        - --source=/var/www/ygk.ca
        ports:
        - containerPort: 1313
      volumes:
      - name: website-data
        gitRepo:
          repository: https://github.com/JonPulsifer/ygk.ca.git
          revision: HEAD
```
