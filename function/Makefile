FUNCTION = test-function

GCLOUD  = $(shell make -sC .. gcloud)

PROJECT_NUMBER = $(shell make -sC .. project-number)
SERVICE_ACCOUNT = ${PROJECT_NUMBER}-compute@developer.gserviceaccount.com

enable:
	${GCLOUD} services enable cloudfunctions.googleapis.com

deploy:
	${GCLOUD} functions deploy ${FUNCTION} --gen2 --trigger-http \
		--runtime=python312 --source=function --entry-point=handler \
		--set-secrets=DB_IP=test-postgres-ip:latest,DB_PASSWORD=test-postgres-password:latest \
		--project=${PROJECT} --region=${REGION}

grant-secret-access:
	${GCLOUD} projects add-iam-policy-binding ${PROJECT} \
		--member=serviceAccount:${SERVICE_ACCOUNT} --role=roles/secretmanager.secretAccessor
