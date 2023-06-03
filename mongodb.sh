cp mongo.repo /etc/yum.repos.d/mongo.repo

yum install mongodb-org -y
### now we need to change the local address from 127.0.0.0.1 to 0.0.0.0
### for finding give like netstat -lntp
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/mongod.conf

systemctl enable mongod
systemctl start mongod
systemctl restart mongod