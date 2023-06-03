source common.sh


echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< install python >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"m
yum install python36 gcc python3-devel -y
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< Add application user >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"m
useradd=${app_user}
rm -rf /app
mkdir /app
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< Download the app content>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"m
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< install maven >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"m
cd /app
unzip /tmp/payment.zip
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< install dependencies >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"m

pip3.6 install -r requirements.txt
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< start services >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"m
cp /root/roboshop-shell/payment.service /etc/systemd/system/payment.service
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< start payment services>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"m
systemctl daemon-reload
systemctl enable payment
systemctl start payment