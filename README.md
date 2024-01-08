# Google Cloud examples

## Prerequisites

Export env vars defining your project, region, and zone:

```sh
export PROJECT=my-project-123456
export REGION=europe-west1
export ZONE=b
```

Create `gcloud` container:

```sh
make gcloud-container
```

## Cloud SQL

```sh
make -C sql  enable  deploy
```

## Cloud Functions

```sh
make -C function  enable  grant-secret-access  deploy
```
