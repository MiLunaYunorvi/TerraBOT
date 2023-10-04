
PUBLIC_IP=$1
DB_ENDPOINT=$2
DB_USER=$3
DB_PASSWORD=$4
SSH_KEY="KeyPEM.pem"  # Ruta a la clave SSH
SSH_USER="ubuntu" 


cat <<EOM > .env
PUBLIC_IP="$PUBLIC_IP"
DB_ENDPOINT="$DB_ENDPOINT"
DB_USER="$DB_USER"
DB_PASSWORD="$DB_PASSWORD"
EOM


sudo scp -i KeyPEM.pem .env ubuntu@18.188.137.110:/home/ubuntu
sudo scp -i KeyPEM.pem scriptSecu.sh ubuntu@18.188.137.110:/home/ubuntu

# Comando o script que deseas ejecutar en el servidor remoto
REMOTE_COMMAND="sudo bash /home/ubuntu/scriptSecu.sh"

# Conexión SSH y ejecución remota
ssh -i "$SSH_KEY" "$SSH_USER@$PUBLIC_IP" "$REMOTE_COMMAND"