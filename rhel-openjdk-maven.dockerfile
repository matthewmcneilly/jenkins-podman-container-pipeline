FROM registry.redhat.io/openjdk/openjdk-8-rhel8
# MAINTAINER matthew.mcneilly@ammeonsolutions.com
# RUN yum update 
RUN yum install -y @maven
