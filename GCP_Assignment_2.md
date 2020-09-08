# Below are for DEV/STAGING Environments.

I will go through the points and write my questions / comments

> ### 1. Road map design architecture in GCP for Kafka, Solr cloud, load balancing, CDN, Kubernetes

### DEV Environment
Currently we have the following DEV environment:
- 1 VM with: 3 Zookeeper instances, 3 SolrCloud instances - devided by port numbers
- 1 VM with: 3 Zookeeper instances, 3 Kafka instances - devided by port numbers
- 1 VM with SFTP service configured

Are this configuration enough for DEV envionment? Or need to make some changes, for example:
- first question about external IP addresses of VMs. Are you need static IP addresses or ephemeral (which changes with VM reboot)? I remember you made external IP addresses static manually which may way to possibility of some errors with Terraform management of infrastructure. If you need static IP addreses which preserves they value between VMs power cycles I propose to change Terraform scripts tp include such functionality
- change number of VMs/application instances per VM
- set up authentication on SolrCloud
- set up SSL for services
- etc.

### STAGING Environment
What are the requirements for STAGING environment:
- how many VMs + application instances per VM needed for SolrCloud and Zookeeper?
- how many VMs + application instances per VM needed for Kafka and Zookeeper?
- is it necessary to set up Zookeeper service on separate VMs for serving both SolrCloud and Kafka application instances?

### PRODUCTION Environment
To save time on research and testing I'm start talking about PRODUCTION environment which I plan to take as a base for testing. I will expect to get your opinion about this environment.

At this moment I see the following PRODUCTION environment:
- 3 VMs with Zookeeper instances with serving both for SolrCloud and Kafka clusters. All instances in different GCP regions
- 3 VMs cluster for SolrCloud instances. All instances in different GCP regions
- 3 VMs cluster for Kafka instances. All instances in different GCP regions
- Google Cloud monitoring or separate VM with Prometheus installed - question for additional research



> ### 2. SSL certificates wherever necessary either by using Google SSL Certificates or LetsEncrypt

Please specify what services are need SSL certificates:
- SolrCloud?
- Kafka?
- Zookeeper?
- Google Load Balancing. I suppose to use Google-Managed SSL certificates to simplify management.
Based on this we develop optimal decision about SSL certificates management.



> ### 3. Solr authentication login using username/password

I think it is no so time consuming task. I expect to solve it no more than 2 hours.



> ### 4. "Kubernetes cluster using terraforms/anisible".

- are there Kubernetes cluster on Google Cloud? Google Kubernetes Engine?
- Do you have specific requirements to Kubernetes cluster (e.g. number of nodes, spec of each node etc.)? Or we will make desicion based on research?

In general writing Terraform/Ansible scripts for deploy GKE cluster will take from 4 hours depending on complexity of cluster.



> ### 5. Flux for deployment of microservices using K8E (Will explain with sample code)
I'm not familiar with Flux product but it is some part of GitOps. Maiby I will need your help with this. But I will not charge time consumed for learning this product



> ### 6. HA of kafka & Solr Cloud for DEV/STAGING Environment.
- about what level of HA we are talking about?
- are there services must be available even during Google Cloud region outage or only need some minimal monitoring for detect unresponsible app and automatic restart?



> ### 7. Stack driver logs to ELK stack for DEV/STAGING
Need additional research. I'm not familiar with ELK stack.



> ### 8. Memory issues for all medico mircroservices
- can you provide configuration details about current Kubernetes cluster on which you have memory issues? At least number of worker nodes and spec of each node
- what are purpose of applications logical grouping? Just for convenience? Or it is needed to be considered then placing pods on k8s nodes (affinity rules)? 

```
## Resource usage
### Develop
>--------------------------------------------------------------------------------------
|	 |					       |       Request		  |         Limits		  | 1        |
|S.No| Service       		   | CPU     | Memory (MB) | CPU      | Memory (MB)| Replicas |
|	 |---------------		   |---------|-------------|----------|------------|----------|
| 1. |medico-audit-trail       |  300m    | 256Mi      |  600m    | 600Mi      | 1        |

| 2. |medico-aadhaarapi        |  200m    | 128Mi      |  400m    | 256Mi      | 1        |

| 3. |medico-auth0	           |  200m    | 128Mi      |  400m    | 256Mi      | 1        |

| 4. |medico-b2b      		   |  300m    | 256Mi      |  600m    | 512Mi      | 1        |

| 5. |medico-cart      		   |  300m    | 256Mi      |  300m    | 256Mi      | 1        |

| 6. |medico-extras            |  200m    | 128Mi      |  400m    | 256Mi      | 1        |

| 7. |medico-geolocationapi    |  200m    | 128Mi      |  400m    | 256Mi      | 1        |

| 8. |medico-gstapi      	   |  200m    | 128Mi      |  400m    | 256Mi      | 1        |

| 9. |medico-masterdata        |  300m    | 256Mi      |  600m    | 512Mi      | 1        |

|10. |medico-orders            |  300m    | 256Mi      |  600m    | 512Mi      | 1        |

|11. |medico-products          |  300m    | 256Mi      |  600m    | 512Mi      | 1        |

|12. |medico-products-inventory|  300m    | 256Mi      |  600m    | 512Mi      | 1        |

|13. |medico-products-search   |  300m    | 256Mi      |  600m    | 512Mi      | 1        |

|14. |medico-registration      |  300m    | 256Mi      |  600m    | 512Mi      | 1        |

|**Total**      		       | **3700** | **2944**   | **7100** |**5720**	   | 14       |

Logical Grouping for Kubernetes Cluster
Products Cluster:
    1. medico-products
	2. medico-products-inventory
	3. medico-products-search

3rd Party Services:
	1. medico-aadhaarapi 
	2. medico-geolocationapi
	3. medico-gstapi

Registration:
	1. medico-registration
	2. medico-masterdata
	3. medico-b2b

Services: 
	1. medico-cart
	2. medico-orders

Necessaries:
	1. medico-audit-trail
	2. medico-auth0
	3. medico-extras
```