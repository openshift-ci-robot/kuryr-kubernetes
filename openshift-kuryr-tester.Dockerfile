FROM rhel7:latest

ENV container=oci

RUN yum update -y \
 && yum install -y python-devel python-pbr python-pip \
 && yum clean all \
 && rm -rf /var/cache/yum \
 && pip install -U pip==20.3.3 \
 && pip config --global set global.cert /etc/ssl/certs/ca-bundle.crt \
 # need to make sure up to date certs are used by pip as apparently pip uses its
 # own certificates and those got outdated as we're pinning pip to an old version that still has Python 2 support.
 && pip install "more-itertools<6.0.0" tox
 # more-itertools 6.0.0 drops support for Python 2.7, so we need to ensure we have older version.

LABEL \
        io.k8s.description="This is a component of OpenShift Container Platform and provides a testing container for Kuryr service." \
        maintainer="Michal Dulko <mdulko@redhat.com>" \
        name="openshift/kuryr-tester" \
        io.k8s.display-name="kuryr-tester" \
        version="3.11.0" \
        com.redhat.component="kuryr-tester-container"
