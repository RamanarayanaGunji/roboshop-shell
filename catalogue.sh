echo -e "\e[31m configurationrepos\e[0m"

curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[31m installing nodejs software \e[0m"
yum install nodejs -y
echo -e "\e[31m add application user \e[0m"
useradd roboshop
echo -e "\e[31m creating app directory \e[0m"
rm -rf /app
rmdir /app
mkdir /app
echo -e "\e[31m download app content \e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
echo -e "\e[31m go to app directory/change directory \e[0m"
cd /app
echo -e "\e[31m unzip the files \e[0m"
unzip /tmp/catalogue.zip
echo -e "\e[31m install nodejs/npm \e[0m"
npm install
echo -e "\e[31m copy the catalogue.service into  \e[0m"
cp /root/roboshop-shell/catalogue.service /etc/systemd/system/catalogue.service
echo -e "\e[31m Start the services \e[0m"
systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue
echo -e "\e[31m cpoy mongo repos \e[0m"
cp /root/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[31m install mongo db client \e[0m"
yum install mongodb-org-shell -y
echo -e "\e[31m load schema \e[0m"
mongo --host mongodb.devopsb72r.online </app/schema/catalogue.js