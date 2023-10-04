
#INSTALANDO NODE EN VERSION 18.X
sudo apt-get update
sudo apt install curl -y
sudo apt-get install -y ca-certificates curl gnupg
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
NODE_MAJOR=18
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt-get update
sudo apt-get install nodejs -y

#CLONANDO REPOSITORIO
git clone https://github.com/MiLunaYunorvi/SecuBot
cd SecuBot
sudo npm ci   #Instalando librerias desde package-lock.json
sudo npm install dotenv --save
sudo cp /home/ubuntu/.env ./.env
sudo cp framework.js node_modules/webex-node-bot-framework/lib/framework.js
screen
sudo npm run start:both
exit 
echo -e "TODO FUNCIONANDO"