# Apache Kafka Server
Install a number of Kafka instances on the single host. Assings Kafka instances on different TCP ports.

## Role Variables

* `kafka_distribution_url`: URL for download Apache Kafka distribution
* `kafka_distribution_dest`: Where to download Apache Kafka distribution
* `kafka_root`: Root folder for Kafka files
* `kafka_service_user`: User for Kafka services
* `kafka_service_user_password`: Password of Kafka services user. Command to generate password: `ansible all -i localhost, -m debug -a "msg={{ 'Hdosuwn763Hgpo' | password_hash('sha512', 'mysalt') }}"`
* `kafka_instances_count`: How many instances of Kafka we should run
* `kafka_dns_name`: DNS name of Kafka host

