# Apache Zookeeper Server
Install a number of Zookeeper instances on the single host. Assings Zookeeper instances on different TCP ports.

## Role Variables

* `zookeeper_distribution_url`: URL for download Apache Zookeeper distribution
* `zookeeper_distribution_dest`: Where to download Apache Zookeeper distribution
* `zookeeper_root`: Root folder for Zookeeper files
* `zookeeper_service_user`: User for Zookeeper services
* `zookeeper_service_user_password`: Password of Zookeeper services user. Command to generate password: `ansible all -i localhost, -m debug -a "msg={{ 'Hdosuwn763Hgpo' | password_hash('sha512', 'mysalt') }}"`
* `zookeeper_instances_count`: How many instances of Zookeeper we should run

