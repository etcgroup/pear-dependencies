## CREATE A FRESH PEAR INSTALLATION ##

# Add local pear to the path
export PATH=/home/jenkins/pear/bin:$PATH

# Install pear
echo "Installing a fresh PEAR"
# Only download a fresh go-pear if needed
wget -nc http://pear.php.net/go-pear.phar -O ${WORKSPACE}/go-pear.phar | true
php ${WORKSPACE}/go-pear.phar

# Use the new php.ini
mv /home/jenkins/pear/php.ini-gopear /home/jenkins/pear/php.ini | true

# IMPORTANT
# This needs to be in the environment in order to actually use the local pear
export PHPRC=/home/jenkins/pear

# Make a cache dir for pear
# Without this, pear will not install anything
mkdir -p /scratch/jenkins/pear_cache
pear config-set cache_dir /scratch/jenkins/pear_cache

# Print the pear version and configuration
pear version
pear config-show

# Install phpqatools and phpDox
pear config-set auto_discover 1
pear install pear.phpqatools.org/phpqatools pear.netpirates.net/phpDox-0.4.0

# Create an archive of the pear installation
mkdir -p ${WORKSPACE}/archive
tar -czf ${WORKSPACE}/archive/pear.tar.gz /home/jenkins/pear
