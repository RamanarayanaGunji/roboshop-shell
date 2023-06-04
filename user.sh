script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
component=user
setup_schema=mongo
echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< function calling >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
func_nodejs
