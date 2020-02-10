https://gitlab.com/matthewmcneilly/aib-demo.git


# Pull dockerfile using git 

# List RHEL Release 
cat /etc/redhat-release

# Disable SELinux 
# yum install container-selinux -y 
# sestatus
# sudo sed -i 's/enforcing/disabled/g' /etc/selinux/config /etc/selinux/config
# cat /etc/selinux/config
# sestatus
# getenforce 

# Add Extra Repo
sudo subscription-manager repos --enable=rhel-7-server-extras-rpms
sudo yum repolist

# Install Podman Buildah
yum install podman -y
yum install buildah -y
podman --version
buildah --version 

# Inspect and Pull Remote Image 
skopeo inspect --creds=matthew.mcneilly@ammeon.com:b39gy9VgMy docker://registry.redhat.io/openjdk/openjdk-8-rhel8
podman pull --creds=matthew.mcneilly@ammeon.com:b39gy9VgMy docker://registry.redhat.io/openjdk/openjdk-8-rhel8
# Build New "Golden Image" 
podman build -f /var/lib/jenkins/workspace/AIB/rhel-openjdk-maven.dockerfile -t maven-openjdk1.8-rhel8
podman images


# Remove Existing Container 
buildah rm --all 
# Build Container from "Golden Image" 
buildah from --name "golden-image" localhost/maven-openjdk1.8-rhel8 
buildah containers
buildah run golden-image mvn -v
# buildah run --tty golden-image mvn -v



# Qualys Details 
https://qualysguard.qg2.apps.qualys.eu/
ammen5mm2
ZRsx6uD%
Amm3onS0lutions@2020

# Image Details 
localhost/maven-openjdk1.8-rhel8             latest   6d754c42e136   5 days ago    575 MB
registry.redhat.io/openjdk/openjdk-8-rhel8   latest   775a34ab4212   4 weeks ago   506 MB


