# Onboarding plan

**Full name**: Serhii Chernukha

**Job position**: DevOps Engineer
___
Task  | Deadline
------------- | -------------
1.Workflow  | 10.2.2020
2.Docker  | 10.2.2020/14.2.2020
3.Kubernetes | 17.2.2020/21.2.2020
4.Jenkins  | 24.2.2020/28.2.2020
5.ELK Stack  | 2.3.2020/6.3.2020
6.Terraform  | 9.3.2020/13.3.2020

![](https://i.paste.pics/842465d34060226bbe591561d808423b.png?trs=f6009fac31c07e6ac9e276bf728abce1f2845bf446fb75be32daf440558621e0)

### Task 1

Be familiar with team’s **Project Workflow**.
**Expected result**: each task below should be fulfilled
according to Project Workflow.

### Task 2

Know how to work with **Docker**. Be able to Dockerize any
application: **Ruby, PHP, Python, Java**. Select any available
free web apps based on each technology and dockerize
them. **Expected result**: docker-compose files for each
application type. Applications should be accessible and
work as expected (or described).

### Task 3

Know **Kubernetes** Resources:
*Deployment, ReplicationController, ReplicaSet,
DaemonSet, StatefulSet, PetSet, Service, Ingress,
Endpoint, Pod, Node, ConfigMap, Secret, Namespace,
PersistentVolume, PersistentVolumeClaim,
ServiceAccount, HorizontalPodAutoscaler*. Be able to
design web application setup on top of kubernetes from
scratch. Be able to implement any (not the only designed
previously) setup on top of kubernetes. One of applications
from step 1 or completely another will be selected for this
task.
**Expected result**: a set of kubernetes manifests for creating
environment. Application should be accessible and work as
expected (or described).

### Task 4

Know how to work with **Jenkins**. Create Jobs,
Parameterized *Jobs, Pipelines, Set up webhooks and triggers*. Create a **CI/CD** process for the same app as for step 2.
**Expected result**: a job or a set of jobs for building and
deploying new application version to kubernetes.
Application should be accessible and work as expected (or
described).

### Task 5

Be familiar with **Prometheus** and **Grafana**, be familiar with
**ELK/EFK**. Know how to set them up in Kubernetes.
**Expected result**: Prometheus and Grafana are displaying
proper data of Kubernetes cluster. ELK/EFK collects data
from the Kubernetes cluster.

### Task 6

Know **Terraform** Data Sources and Resources. Be able to
design and implement any infrastructure on top of AWS and
GCP. Use the same app as for step 2. Do not use
containers.
**Expected result**: a set of Terraform manifests for creating
environment. Application should be accessible and work as
expected (or described).
