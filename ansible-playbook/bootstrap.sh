#!/bin/bash
shopt -s extglob

apt-get install -y software-properties-common
apt-add-repository -y ppa:ansible/ansible
apt-get update
apt-get install -y ansible
mv /etc/ansible/hosts /etc/ansible/hosts.orig
mkdir -p /etc/ansible/facts.d/

FILES=("./../"*.fact)
for f in "${FILES[@]}"
do
    cp "${f}" /etc/ansible/facts.d/.
done

cat > /etc/ansible/hosts <<EOF
localhost ansible_connection=local
EOF
