echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< install maven >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"m
yum install maven -y
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< add user and directory(app) >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"m

useradd roboshop
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
cp /root/roboshop-shell/shipping.service /etc/systemd/system/shipping.serviceecho -e
systemctl enable shipping
systemctl start shipping
yum install mysql -y

mysql -h mysql.devopsb72r.online -uroot -pRoboShop@1 < /app/schema/shipping.sql


systemctl restart shipping