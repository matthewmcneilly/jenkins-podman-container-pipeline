FROM registry.redhat.io/openjdk/openjdk-8-rhel8
USER root
RUN yum install -y @maven
