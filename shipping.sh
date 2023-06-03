
script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
mysql _root_password=$1
yum install maven -y
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< add user and directory(app) >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"m

useradd ${app_user}
rm -rf /app
mkdir /app
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< Download app content >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"m

curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip

echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< unzip/extract app content the file>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"m
cd /app
unzip /tmp/shipping.zip

echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<<download maven dependencies>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"m

mvn clean package
mv target/shipping-1.0.jar shipping.jar
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< install mysql and load the schema >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"m
cp /root/roboshop-shell/shipping.service /etc/systemd/system/shipping.service
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< start services >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"m
systemctl enable shipping
systemctl start shipping
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< install mysql >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"m
yum install mysql -y
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< passing passowrd as user input >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"m
mysql -h mysql.devopsb72r.online -uroot -p${mysql _root_password} < /app/schema/shipping.sql

echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<<restart the shipping >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"m
systemctl restart shipping