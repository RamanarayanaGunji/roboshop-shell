script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh


echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< install  GOlang >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"m
yum install golang -y
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< Add application useras roboshop >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"m
useradd  ${app_user}
rm -rf /app
mkdir /app
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< download roboshop-artifacts >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"m
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< extract data from file >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"m
cd /app
unzip /tmp/dispatch.zip
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< dispatching >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"m
go mod init dispatch
go get
go build
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< start services >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"m
cp /root/roboshop-shell/dispatch.service /etc/systemd/system/dispatch.service
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< start services >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"m
systemctl daemon-reload
systemctl enable dispatch
systemctl start dispatch