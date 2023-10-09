## Spin Up

```bash
# Envs
      - DB_HOST=host.docker.internal
```

## Deployment to ECR

```bash
$ aws configure
$ deploy/docker/scripts/push-image.sh

# OR; use rake instead

$ aws configure
$ rake docker:push
```