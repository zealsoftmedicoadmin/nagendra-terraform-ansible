# Apache Solr Server
Install a number of Solr instances on the single host. Assings Solr instances on different TCP ports.

## Role Variables

* `solr_distribution_url`: URL for download Apache Solr distribution
* `solr_distribution_dest`: Where to download Apache Solr distribution
* `solr_root`: Root folder for Solr files
* `solr_service_user`: User for Solr services
* `solr_service_user_password`: Password of solr services user. Command to generate password: `ansible all -i localhost, -m debug -a "msg={{ 'Hdosuwn763Hgpo' | password_hash('sha512', 'mysalt') }}"`
* `solr_instances_count`: How many instances of solr we should run
* `solr_dns_name`: DNS name of Solr host

