#!/bin/bash

ansible app -b -m yum -a 'name=MySQL-python state=present'
ansible app -b -m yum -a 'name=python-setuptools state=present'
ansible app -b -m yum -a 'name=python3-pip state=present'
ansible app -b -m pip3 -a 'name=django'
