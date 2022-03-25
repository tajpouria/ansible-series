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
