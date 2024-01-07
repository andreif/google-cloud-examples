# Google Cloud examples

## Prerequisites

Export env vars defining your project, region, and zone:

```sh
export PROJECT=my-project-123456
export REGION=europe-west1
```

Create `gcloud` container:

```sh
make gcloud-container
```

## Cloud Functions

```sh
make -C function enable deploy
```
