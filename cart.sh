script=$(realpath "$0")
realpath $0
exit
script_path=$(dirname "$script")

source common.sh

echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< open node source >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< install node js >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
yum install nodejs -y
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< add user as roboshop and creat directoty as app>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
useradd ${app_user}
rm -rf /app
mkdir /app
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< downlaod file >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< unzip the file >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
cd /app
unzip /tmp/cart.zip
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< install npm >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
npm install
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< copy cart services >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
cp /root/roboshop-shell/cart.service /etc/systemd/system/cart.service
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< start services >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
systemctl daemon-reload
systemctl enable cart
systemctl start cart