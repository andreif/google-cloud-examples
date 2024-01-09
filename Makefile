GCLOUD_IMG = gcr.io/google.com/cloudsdktool/google-cloud-cli:alpine
GCLOUD_CONTAINER = gcloud
GCLOUD_EXEC = docker exec -ti ${GCLOUD_CONTAINER}
GCLOUD = ${GCLOUD_EXEC} gcloud
PLATFORM = $(shell uname -m | grep -q 'arm64' && echo '--platform linux/arm64')

gcloud-container:  auth  config-set

auth:  remove-existing-container
	docker run -ti ${PLATFORM} -v .:/app -w /app --name ${GCLOUD_CONTAINER} ${GCLOUD_IMG} \
		gcloud auth login --brief
	docker start ${GCLOUD_CONTAINER}

remove-existing-container:
	@docker rm -f ${GCLOUD_CONTAINER} 2>/dev/null || true

config-set:  check-vars
	${GCLOUD} config set core/project     ${PROJECT}
	${GCLOUD} config set functions/region ${REGION}
	@echo
	make config-list

check-vars:
	@test -n "${PROJECT}" || (echo "Error: PROJECT env var not set!"; exit 1)
	@test -n "${REGION}"  || (echo "Error: REGION  env var not set!"; exit 1)
	@test -n "${ZONE}"    || (echo "Error: ZONE    env var not set!"; exit 1)

config-list:
	${GCLOUD} config list

gcloud:
	@echo ${GCLOUD}

gcloud-exec:
	@echo ${GCLOUD_EXEC}

project-number:  check-vars
	@${GCLOUD} projects describe ${PROJECT} --format='value(projectNumber)'
