apt-get install -y software-properties-common
apt-add-repository -y ppa:ansible/ansible
apt-get update
apt-get install -y ansible
mv /etc/ansible/hosts /etc/ansible/hosts.orig
cat > /etc/ansible/hosts <<EOF
localhost ansible_connection=local
EOF
ansible-playbook -s basic.yaml
