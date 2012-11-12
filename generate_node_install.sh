# Install node.js
NODE_VERSION=0.8.8

set -e

if [[ -z $NODE_VERSION ]]; then
   echo "You must set the NODE_VERSION environment variable. See http://wiki.cloudbees.com/bin/view/DEV/Node+Builds" 1>&2
fi

mkdir -p /scratch/jenkins/nodes
ARCH=`uname -m`

node_name=node-${NODE_VERSION}-${ARCH}

test -f /scratch/jenkins/nodes/${node_name}.zip ||  wget -q -P /scratch/jenkins/nodes https://repository-cloudbees.forge.cloudbees.com/distributions/ci-addons/node/${node_name}.zip > /dev/null

test -f /scratch/jenkins/nodes/${node_name}/bin/node || unzip -d /scratch/jenkins/nodes /scratch/jenkins/nodes/${node_name}.zip > /dev/null

rm -f /scratch/jenkins/nodes/node
ln -s /scratch/jenkins/nodes/${node_name} /scratch/jenkins/nodes/node

export PATH=/scratch/jenkins/nodes/node/bin:$PATH

export clean=yes
export skipclean=no
curl https://npmjs.org/install.sh | sh

npm install jshint csslint phantom -g

tar -czf ${WORKSPACE}/archive/node.tar.gz /scratch/jenkins/nodes