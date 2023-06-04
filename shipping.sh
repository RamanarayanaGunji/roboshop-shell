
script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
mysql_root_password=$1
component=shipping
if [-z ${mysql_root_password}];
then
  echo input roboshop password is missing
  exit
fi

###mysql -h mysql.devopsb72r.online -uroot -p${mysql_root_password} < /app/schema/shipping.sql
func_java
