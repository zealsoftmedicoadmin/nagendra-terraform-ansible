## Docker compose files for deploying Apache Zookeeper/Solr/Kafka environments

Folder structure:  
- `kafka/docker-compose.yml` - Docker compose file for deploying:
    - 3 Zookeeper containers
    - 3 Kafka containers
    - 1 Confluent Schema Registry container
- `solr/docker-compose.yml` - Docker compose file for deploying:
    - 3 Zookeeper containers
    - 3 Solr containers

- each environment deploys in separate docker network. But Zookeeper containers exposes into host system similar port numbers, so without changing Zookeeper ports numbers there are not possible to make both deployments at the same time
- there is no persistent volumes configured for containers data, all data kept inside containers
