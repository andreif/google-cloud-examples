FUNCTION = test-function

GCLOUD  = $(shell make -sC .. gcloud)

PROJECT_NUMBER = $(shell make -sC .. project-number)
SERVICE_ACCOUNT = ${PROJECT_NUMBER}-compute@developer.gserviceaccount.com

INSTANCE = $(shell make -sC ../sql instance)
USER = $(shell make -sC ../sql user)
DATABASE = postgres
PASSWORD_SECRET = ${INSTANCE}-password:latest

enable:
	${GCLOUD} services enable cloudfunctions.googleapis.com

deploy:
	${GCLOUD} functions deploy ${FUNCTION} --gen2 --trigger-http \
		--runtime=python312 --source=function --entry-point=handler \
		--set-env-vars=DB_USER=${USER},DB_DATABASE=${DATABASE},DB_CONNECTION=${PROJECT}:${REGION}:${INSTANCE} \
		--set-secrets=DB_PASSWORD=${PASSWORD_SECRET} \
		--project=${PROJECT} --region=${REGION}

describe:
	${GCLOUD} functions describe ${FUNCTION}

grant-secret-access:
	${GCLOUD} projects add-iam-policy-binding ${PROJECT} \
		--member=serviceAccount:${SERVICE_ACCOUNT} --role=roles/secretmanager.secretAccessor
