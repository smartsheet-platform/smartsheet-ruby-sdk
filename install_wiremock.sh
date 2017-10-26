#!/usr/bin/env sh

WIREMOCK_DOWNLOAD='Smartsheet-WireMock-Bundle.zip'
WIREMOCK_INSTALL_DIR='Smartsheet-WireMock-Bundle'
RELEASE_DOWNLOAD_URL='https://github.com/stollgr/wiremock-scenario-templating/releases/download/0.12/Smartsheet-WireMock-Bundle.zip'

# download wiremock
curl $RELEASE_DOWNLOAD_URL -L -s -o $WIREMOCK_DOWNLOAD

# unzip wiremock
unzip -qq $WIREMOCK_DOWNLOAD
