source common.sh

echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< installing user nodejs >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"

curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< installing nodejs >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
yum install nodejs -y
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< adding roboshop username >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
useradd =${app_user}
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< creating app directory >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
rm -rf /app
rmdir /app
mkdir /app
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< Downloading app content >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip

echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< changing the directory >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
cd /app
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< unzip the content >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
unzip /tmp/user.zip
cd /app
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< install npm >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
npm install
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< copy files >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
cp /root/roboshop-shell/user.service /etc/systemd/system/user.service
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< start service  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
systemctl daemon-reload
systemctl enable user
systemctl start user
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< copy the file >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
cp /root/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< install mongodb >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
yum install mongodb-org-shell -y
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< changing mongo ip address >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
mongo --host mongodb.devopsb72r.online </app/schema/user.js