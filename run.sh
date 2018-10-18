#!/bin/sh

ansible-playbook -K -i hosts/asus-n56vj.yml playbook.yml "$@"
