INSTANCE = test-postgres
USER = postgres
PASSWORD := $(shell openssl rand -base64 24)

GCLOUD  = $(shell make -sC .. gcloud)
GCLOUD_EXEC  = $(shell make -sC .. gcloud-exec)

enable:
	${GCLOUD} services enable sqladmin.googleapis.com
	${GCLOUD} services enable secretmanager.googleapis.com

deploy:  instances-create  secrets-set-password
rotate-password:  users-set-password  secrets-set-password

user:
	@echo ${USER}

instance:
	@echo ${INSTANCE}

instances-create:
	${GCLOUD} sql instances create ${INSTANCE} --zone=${REGION}-${ZONE} \
	 	--database-version=POSTGRES_15 --cpu=2 --memory=4GiB --root-password="${PASSWORD}"

instances-delete:
	${GCLOUD} sql instances delete ${INSTANCE}

define find-secret
$if( $(shell ${GCLOUD} secrets list --filter="name:$(1)" --format="get(name)" | \
grep "not present in any resource"),,found)
endef

define set-secret
	$(if $(if $(call find-secret,$(1)), $(shell ${GCLOUD} secrets create $(1)) ),)
	$(if $(shell ${GCLOUD_EXEC} bash -c 'echo -n "$(2)" > /tmp/secret' ),)
	${GCLOUD} secrets versions add $(1) --data-file=/tmp/secret
	${GCLOUD_EXEC} rm -rf /tmp/secret
endef

secrets-list:
	${GCLOUD} secrets list

secrets-set-password:
	$(call set-secret,${INSTANCE}-password,${PASSWORD})

instances-describe:
	${GCLOUD} sql instances describe ${INSTANCE}

users-set-password:
	${GCLOUD} sql users set-password ${USER} --instance=${INSTANCE} --password="${PASSWORD}"

instance-set-authorized-networks:
	test -n "${MYIP}"
	${GCLOUD} sql instances patch ${INSTANCE} --authorized-networks=${MYIP} --quiet


