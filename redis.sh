echo -e "\e[31m >>>>>>> installing redis repos <<<<<<<<<<<<<<\e[0m"

yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y

echo -e "\e[31m <<<<<<<<<<<<<<<enable  redis>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> \e[0m"
yum module enable redis:remi-6.2 -y

echo -e "\e[31m enable  redis \e[0m"
yum install redis -y
echo -e "\e[31m>>>>>>>>>>>>>>>>>>>>>>>> updateing redis listen address <<<<<<<<<<<< \e[0m"
sed -i -e 's|127.0.0.1 | 0.0.0.0|' /etc/redis.conf /etc/redis/redis.conf
### to check the status is netstat-lntp
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< enable  redis >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
systemctl enable redis
systemctl start redis