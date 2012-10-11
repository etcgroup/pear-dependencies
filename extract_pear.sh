## INSTALL PREPARED PEAR PACKAGES ##

# Add local pear to the path
export PATH=/home/jenkins/pear/bin:$PATH

# IMPORTANT
# This needs to be in the environment in order to actually use the local pear
export PHPRC=/home/jenkins/pear

# Extract pear installation
tar -C / -xzf ${PRIVATE_DIR}/pear.tar.gz

# Print the pear version and configuration
pear version
pear config-show
