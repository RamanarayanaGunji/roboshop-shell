echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< disable mysql 8 version old version>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
yum module disable mysql -y
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< copy the file >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
cp /root/roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< install my sql >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
yum install mysql-community-server -y
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< start services >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
systemctl enable mysqld
systemctl start mysqld
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< secure installations >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"m
if [-z ${mysql_app_user_password}];
then
  echo input roboshop password is missing
  exit
fi
mysql_secure_installation --set-root-pass RoboShop@1
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< password credentials >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
