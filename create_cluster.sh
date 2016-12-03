server=$@

ssh -i "${HOME}/.ssh/google_compute_engine" "ubuntu@${server}" "mkdir -p ~/gce_invoker"
rsync -Pav -e "ssh -i ${HOME}/.ssh/google_compute_engine" . "ubuntu@${server}:gce_invoker/"
ssh -i "${HOME}/.ssh/google_compute_engine" "ubuntu@${server}" "cd ~/gce_invoker/ansible-playbook && sudo ./bootstrap.sh"
ssh -i "${HOME}/.ssh/google_compute_engine" "ubuntu@${server}" "cd ~/gce_invoker/ansible-playbook && ansible-playbook -s kube.yaml"
