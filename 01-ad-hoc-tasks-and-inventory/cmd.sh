#!/bin/bash

ansible app -b -m yum -a 'name=MySQL-python state=present'
ansible app -b -m yum -a 'name=python-pip state=present'
ansible app -b -m pip -a 'name=django executable=/usr/bin/pip3 state=present'
ansible app -a 'python3 -c "import django; print(django.get_version())"'

ansible db -b -m yum -a 'name=mariadb-server state=present'
ansible db -b -m service -a 'name=mariadb state=started enabled=yes'
ansible db -b -a 'iptables -F' # Flush IP tables rules
ansible db -b -a 'iptables -I INPUT -s 192.168.60.0/24 -p tcp -m tcp --dport 3306 -j ACCEPT'
ansible db -b -a '/sbin/iptables-save'
ansible db -b -m yum -a 'name=MySQL-python state=present'
ansible db -b -m mysql_user -a "name=django host=% password=12345 priv=*.*:ALL state=present"

ansible app -b -m group -a 'name=admin state=present'
ansible app -b -m user -a 'name=johndoe group=admin createhome=yes'
ansible app -b -m user -a 'name=johbdoe state=absent remove=yes'

ansible multi -m stat -a 'path=/etc/environment'

ansible multi -m copy -a 'src=/etc/hosts dest=/tmp/hosts'

ansible multi -m fetch -a 'src=/etc/hosts dest=/tmp/hosts'

ansible multi -m file -a "dest=/tmp/test mode=644 state=directory"
ansible multi -m file -a "src=/src/symlink dest=/dest/symlink owner=root group=root state=link"
ansible multi -m file -a "dest=/tmp/test state=absent"

ansible multi -b -B 3600 -a 'yum -y update'

ansible multi -b -m cron -a 'name=daily-cron-all-servers hour=4 job="/path/to/daily-script.sh"'
ansible multi -b -m cron -a "name='daily-cron-all-servers' state=absent"
