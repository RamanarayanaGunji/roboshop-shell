script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
#/root/roboshop-shell/
#source common.sh
component=cart
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<<function calling >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
func_nodejs

