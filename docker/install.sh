#!/bin/sh

chmod +x /tmp/lingk-fission-cli.jar
(echo '#!/usr/bin/java -jar'; cat /tmp/lingk-fission-cli.jar) > /usr/bin/lingk
chmod +x /usr/bin/lingk

# cleanup
# do all in one step
set -ex 
apk update 
apk add --update bash ca-certificates git python zip openssh
apk add --update -t deps curl make py-pip openssl

curl -L https://github.com/fission/fission/releases/download/1.6.0/fission-cli-linux -o /usr/local/bin/fission
chmod +x /usr/local/bin/fission

#uncomment more for developer-aspect
#curl -L "https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
#mv /tmp/eksctl /usr/local/bin

#uncomment more for developer-aspect
#curl -L https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl
#chmod +x /usr/local/bin/kubectl

#uncomment more for developer-aspect
#curl -sLSf https://raw.githubusercontent.com/helm/helm/master/scripts/get | bash

# awscli
pip install awscli
aws --version

# install YAML tools
pip install yamllint yq

# cleanup
apk del --purge deps
rm /var/cache/apk/*
rm -rf /tmp/*

