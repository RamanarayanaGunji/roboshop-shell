echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<<create a varibale for password >>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"m
rabbitmq_app_user_password=$1
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<<setup erlarge reposs>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"m
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<set up Rabbit mq  repos>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"m
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<<install  ERlang and rabbitmq >>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"m
yum install rabbitmq-server -y
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<<Start rabbitmq services>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"m
systemctl enable rabbitmq-server
systemctl start rabbitmq-server
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<<Add application user to rabbitmq and passing password >>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"m
rabbitmqctl add_user roboshop ${rabbitmq_app_user_password}
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"