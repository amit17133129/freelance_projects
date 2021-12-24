#!/bin/bash

sed  -i '1i [client]' user_file.txt

ansible-vault encrypt user_file.txt  --vault-password-file  a.txt

cat user_file.txt

ansible-playbook final_user.yml  --vault-password-file  a.txt

#rm -rf a.txt
