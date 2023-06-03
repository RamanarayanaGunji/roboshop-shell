script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
component=catalogue
echo -e "\e[31mfuncton caliing>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
func_nodejs
echo -e "\e[31m cpoy mongo repos \e[0m"
cp /root/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[31m install mongo db client \e[0m"
yum install mongodb-org-shell -y
echo -e "\e[31m load schema \e[0m"
mongo --host mongodb.devopsb72r.online </app/schema/catalogue.js