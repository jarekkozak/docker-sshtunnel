# Generate rsa keys 

if [ ! -f ./keys/id_rsa ]; then
  ssh-keygen -f ./keys/id_rsa -N '' -t rsa
  sshpass -p $PASS ssh-copy-id -i ./keys/id_rsa.pub -o StrictHostKeyChecking=no $HOST
fi

