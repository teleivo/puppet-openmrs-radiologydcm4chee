#!/bin/bash
# Deploy puppet environments and apply one of them

if [ -z "${1}" ]; then
 echo "Puppet environment missing!"
 exit 1
fi
PP_ENVIRONMENT="${1}"

PP_CONTROL_REPO_DIR='/vagrant/'
PP_ENVIRONMENT_DIR='/etc/puppet/environments/'

r10k deploy -c "${PP_CONTROL_REPO_DIR}r10k.yaml" environment &&
cd "${PP_ENVIRONMENT_DIR}${PP_ENVIRONMENT}" &&
puppet apply manifests/site.pp --hiera_config hiera.yaml --modulepath site:modules
