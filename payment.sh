script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
payment_app_user_password=$1


if [-z ${payment_app_user_password}];
then
  echo input roboshop password is missing
  exit
fi
component=payment
schema_setup=mysql
func_payment