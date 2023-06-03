script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
component=user
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< function calling >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
func_nodejs
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< copy the file >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
cp /root/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< install mongodb >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
yum install mongodb-org-shell -y
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< changing mongo ip address >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
mongo --host mongodb.devopsb72r.online </app/schema/user.js