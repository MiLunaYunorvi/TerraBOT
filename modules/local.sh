
PUBLIC_IP=$1
DB_ENDPOINT=$2
DB_USER=$3
DB_PASSWORD=$4
SSH_KEY="KeyPEM.pem"  # Ruta a la clave SSH
SSH_USER="ubuntu" 
tocino44

cat <<EOM > .env
PUBLIC_IP="$PUBLIC_IP"
DB_ENDPOINT="$DB_ENDPOINT"
DB_USER="$DB_USER"
DB_PASSWORD="$DB_PASSWORD"
EOM


sudo scp -oStrictHostKeyChecking=no -i KeyPEM.pem .env ubuntu@$PUBLIC_IP:/home/ubuntu
sudo scp -oStrictHostKeyChecking=no -i KeyPEM.pem scriptSecu.sh ubuntu@$PUBLIC_IP:/home/ubuntu
echo -e "ARCHIVOS ENVIADOS POR SCP"

# Comando o script que deseas ejecutar en el servidor remoto

REMOTE_COMMAND="screen -d -m -S SecuBOT bash -c 'sudo bash /home/ubuntu/scriptSecu.sh && exit'"

# Conexión SSH y ejecución remota
ssh -oStrictHostKeyChecking=no -i "$SSH_KEY" "$SSH_USER@$PUBLIC_IP" "$REMOTE_COMMAND"
echo -e "TODO FUNCIONANDO"