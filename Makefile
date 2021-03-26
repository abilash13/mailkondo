##### Variables

# Go commands
GOCMD=go
GOBUILD=$(GOCMD) build
GORUN=$(GOCMD) run
GOTEST=$(GOCMD) test

# Build targets
BUILD_OS_DARWIN=darwin
BUILD_OS_WINDOWS=windows
BUILD_OS_LINUX=linux
BUILD_ARCH=amd64
DARWIN_BUILD_ENV_VARS=GOOS=${BUILD_OS_DARWIN} GOARCH=${BUILD_ARCH}
LINUX_BUILD_ENV_VARS=GOOS=${BUILD_OS_LINUX} GOARCH=${BUILD_ARCH}
WINDOWS_BUILD_ENV_VARS=GOOS=${BUILD_OS_WINDOWS} GOARCH=${BUILD_ARCH}

# Golang entries
ENTRYDIR=cmd
APP_ENTRY_DIR=${ENTRYDIR}/mailkondo
APP_ENTRY=${APP_ENTRY_DIR}/mailkondo.go

# Binaries
BINARYDIR=bin
DARWIN_BINARYDIR=${BINARYDIR}/darwin
LINUX_BINARYDIR=${BINARYDIR}/linux
WINDOWS_BINARYDIR=${BINARYDIR}/windows

APP_BINARY=mailkondo

# Environment files
LOCAL_ENV_FILE=.env.local
DEV_ENV_FILE=.env.dev
TEST_ENV_FILE=.env.test
PROD_ENV_FILE=.env.prod

##### Targets

# Test
# TODO: Need to properly set this up.
.PHONY: unittest
unittest:
	$(GOTEST) ./...
.PHONY: test
test: unittest

# Build
.PHONY: build
build:
	$(GOBUILD) -o ${BINARYDIR}/${APP_BINARY} ${APP_ENTRY}
.PHONY: build-darwin
build-darwin:
	${DARWIN_BUILD_ENV_VARS} $(GOBUILD) -o ${DARWIN_BINARYDIR}/${APP_BINARY} ${APP_ENTRY}
.PHONY: build-linux
build-linux:
	${LINUX_BUILD_ENV_VARS} $(GOBUILD) -o ${LINUX_BINARYDIR}/${APP_BINARY} ${APP_ENTRY}
.PHONY: build-windows
build-windows:
	${WINDOWS_BUILD_ENV_VARS} $(GOBUILD) -o ${WINDOWS_BINARYDIR}/${APP_BINARY} ${APP_ENTRY}

# Run
.PHONY: run
run:
	$(GORUN) ${APP_ENTRY} -c ${APP_ENTRY_DIR}/.env.local
.PHONY: run-dev
run-dev:
	$(GORUN) ${APP_ENTRY} -c ${APP_ENTRY_DIR}/.env.dev
.PHONY: run-test
run-test:
	$(GORUN) ${APP_ENTRY} -c ${APP_ENTRY_DIR}/.env.test
.PHONY: run-prod
run-prod:
	$(GORUN) ${APP_ENTRY} -c ${APP_ENTRY_DIR}/.env.prod