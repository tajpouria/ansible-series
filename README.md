# [Ansible of DevOps](https://www.ansiblefordevops.com/)

[Introduction to Ansible](00-introduction-to-ansible)

- Ping a server.
- Run a ad-hoc command.
- Run a playbook that installs and run NTP.

[Ad-hoc tasks and Inventory](01-ad-hoc-tasks-and-inventory)

- Create an inventory file containing three host groups, app with two application host, db with one database host and multi containing both app ad db groups.
- Setup ansible SSH user for private key for the all users inside the inventory file.
- Run an ad-hoc command against all servers with one ansible fork(`-f 1`) process.
- Use the `setup` module to get information about the server.
- Use the `yum` module to make sure the NTP package is present in all of the servers.
- Use the `service` module to make sure the NTP service(ntpd) is running in all of the servers.`
- Use `--ask-become-password` or`K` flag to make ansible ask for root password before executing the ad-hoc command.
- Use the `ansible-doc` command to get the service module documentation.
- Use the `--limit` flag to run an ad-hoc command on one server.

[Introduction to Playbooks](02-introduction-to-playbooks)

- Create a playbook that installs and run Apache
- Use the ansible `with_items` loop to copy the Apache configuration files.

[Your first real world playbook](03-your-first-real-world-playbook)

- Write a playbook that installs and configures Solr
  - Use `pre-tasks` to update the yum cache.
  - Write a `restart solr` handler that uses `service` module to restart Solr when needed.
  - Use the `get_url` module to download Solr and check the tarball checksum.
  - Use the `unarchive` module to expand the Solr tarball.
- Check the syntax using the `ansible-playbook main.yaml --syntax-check` command.

[Playbook Handlers Environment Vars Variables](04-playbook-handlers-environment-vars-variables)

- Write a playbook that install Apache on a CentOS server, copy over the configuration files and restarts the server on configuration files changes user `handlers`.
- Use the Ansible's `meta` module with `flush_handlers` to restart the Apache server right after configuration being copied over.
- Use the `line_in_file` module to add an environment variable to the remote machine, register the environment variable as a variable named foo in the playbook using the shell module, and access its value using the print module.
