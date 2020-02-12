// Ammeon Solutions 2020 AIB Demo

timestamps {

node () {

stage ('Pull Files') {
checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '47da508d-f8b2-490b-99fb-87250daf362b', url: 'https://gitlab.com/matthewmcneilly/aib-demo.git']]])
}

stage ('Prerequisite Steps') {
sh """
# Print out Docker File
cat rhel-openjdk-maven.dockerfile

# Disable SELinux
sudo sed -i 's/enforcing/disabled/g' /etc/selinux/config /etc/selinux/config
cat /etc/selinux/config
# sestatus
getenforce

# Add Extra Repo
sudo subscription-manager repos --enable=rhel-7-server-extras-rpms
sudo yum repolist

# Install Podman Buildah
yum install podman -y
yum install buildah -y
podman --version
buildah --version

# Install Docker (Required for Qualys)
yum install docker -y
systemctl start docker
docker -v

# Install Qualys
tar -xvf QualysContainerSensor.tar.xz
mkdir -p /usr/local/qualys/sensor/data
./installsensor.sh ActivationId=94fb14c1-b6e5-45c9-a978-c4f648a50d49 CustomerId=7580bbd3-f9c4-6934-81b3-fd496a13f7cf Storage=/usr/local/qualys/sensor/data -s -c
"""
}


stage ('Build & Copy Image') {
sh """
# Inspect and Pull Remote Image
skopeo inspect --creds=matthew.mcneilly@ammeon.com:b39gy9VgMy docker://registry.redhat.io/openjdk/openjdk-8-rhel8
podman pull --creds=matthew.mcneilly@ammeon.com:b39gy9VgMy docker://registry.redhat.io/openjdk/openjdk-8-rhel8
# Build New "Golden Image"
podman build -f /var/lib/jenkins/workspace/AIB/rhel-openjdk-maven.dockerfile -t maven-openjdk1.8-rhel8
podman images

# Push image to docker registry for scanning using Qualys
podman push maven-openjdk1.8-rhel8 docker-daemon:maven-openjdk1.8-rhel8:latest
docker images
"""
}


stage ('Build Container') {
sh """
# Cleanup Existing Containers
buildah rm --all

# Build Container from "Golden Image"
buildah from --name "golden-image" localhost/maven-openjdk1.8-rhel8
buildah containers
"""
}


stage ('Functionality Check') {
sh """
# Check Maven Version
buildah run --tty golden-image mvn -v
"""
}

stage('Qualys Scan') {
// Run Qualys Scan on image
getImageVulnsFromQualys imageIds: 'bed9a11c737a', useGlobalConfig: true
}


}
}
