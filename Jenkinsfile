// Powered by Infostretch

timestamps {

node () {

	stage ('Prerequisite Steps') {
sh """
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
# sudo subscription-manager repos --enable=rhel-7-server-extras-rpms
# sudo yum repolist

# Install Podman Buildah
# yum install podman -y
# yum install buildah -y
# podman --version
# buildah --version
 """
	}


  	stage ('Pull Dockerfile') {
   	 checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '47da508d-f8b2-490b-99fb-87250daf362b', url: 'https://gitlab.com/matthewmcneilly/aib-demo.git']]])
  	}


	stage ('Build Image') {
sh """

# Inspect and Pull Remote Image
# skopeo inspect --creds=matthew.mcneilly@ammeon.com:b39gy9VgMy docker://registry.redhat.io/openjdk/openjdk-8-rhel8
# podman pull --creds=matthew.mcneilly@ammeon.com:b39gy9VgMy docker://registry.redhat.io/openjdk/openjdk-8-rhel8
# Build New "Golden Image"
# podman build -f /var/lib/jenkins/workspace/AIB/rhel-openjdk-maven.dockerfile -t maven-openjdk1.8-rhel8
podman images
"""
	}


	stage ('Build Container') {
sh """
# Remove Existing Container
# buildah rm --all
# Build Container from "Golden Image"
# buildah from --name "golden-image" localhost/maven-openjdk1.8-rhel8
buildah containers
buildah run golden-image mvn -v
"""
	}


  	stage ('Functionality Check') {
  sh """
  # buildah run --tty golden-image mvn -v


  # Qualys Scan
  """
  	}


}
}
