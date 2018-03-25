## docker-hugo

This image is built on `alpine:latest` and will attempt to stay current. #patcheswelcome

## kubernetes

You should use `podsecuritypolicy.yaml` to secure this container :)

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hugo
  labels:
    app: hugo
spec:
  replicas: 1
  selector:
    matchLabels:
      app: hugo
  template:
    metadata:
      labels:
        app: hugo
    spec:
      automountServiceAccountToken: false
      containers:
      - name: hugo
        image: gcr.io/kubesec/hugo:0.37.1
        imagePullPolicy: IfNotPresent
        args: ["/usr/bin/hugo", "server", "--bind=0.0.0.0", "--source=/var/www/ygk.ca", "--disableLiveReload"]
        ports:
        - containerPort: 1313
        volumeMounts:
        - mountPath: /var/www
          name: website-data
        - mountPath: /tmp/hugo_cache
          name: hugo-cache
      volumes:
      - name: website-data
        gitRepo:
          repository: https://github.com/jonpulsifer/ygk.ca.git
          revision: HEAD
      - name: hugo-cache
        emptyDir: {}
```
