FUNCTION = test-function

GCLOUD  = $(shell make -sC .. gcloud)

enable:
	${GCLOUD} services enable cloudfunctions.googleapis.com

deploy:
	${GCLOUD} functions deploy ${FUNCTION} --gen2 --trigger-http \
		--runtime=python312 --source=./function --entry-point=handler \
		--project=${PROJECT} --region=${REGION}
