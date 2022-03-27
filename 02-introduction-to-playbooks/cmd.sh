#! /bin/bash

ansible-playbook main.yaml
ansible-playbook main.yaml --limit db
ansible-playbook main.yaml --limit 192.168.60.1
