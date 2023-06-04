##assign roboshop in one variable in the files, where we have this
##  roboshop and able to access to all files
app_user=roboshop

###script=$(realpath "$0")
###script_path=$(dirname "$script")

##declare a function
func_print_head()
{
  echo -e "\e[31m<<<<<<<<<<<<<<<<<<<<<<< $* >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
}

func_schema_setup()
{
  if [ "$schema_setup" == "mongo" ]; then
    func_print_head "copy the file"
    func_checking_status $?
    cp /root/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo
    func_print_head "install mongodb "
    yum install mongodb-org-shell -y
    func_print_head" changing mongo ip address "
    mongo --host mongodb.devopsb72r.online </app/schema/user.js
  fi
func_checking_status $?
  if ["${schema_setup}" == "mysql"]; then
  func_print_head "install mysql "
  yum install mysql -y
  func_print_head " passing password as user input "
  mysql -h mysql.devopsb72r.online -uroot -p${mysql_root_password} < /app/schema/shipping.sql
  fi
   if ["$schema_setup" == "payment" ]; then
    func_print_head "install mysql "
    yum install mysql -y
    func_print_head " passing password as user input "
    sed -i -e "s|payment_app_user_password|${payment_app_user_password}|" ${script_path}/${component}.service

    fi

}
func_checking_status()
{
  func_print_head " function checking status starting "
  if[ $? -eq 0 ]; then
    echo command executes successfully.
  else
    echo FALIED
  func_print_head " function checking_status completed "
  fi
}

func_nodejs()
{
  func_print_head "open node source"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash
  func_checking_status $?
  func_print_head "install node js"
  yum install nodejs -y
  func_checking_status $?
  func_print_head "add user as roboshop and creat directoty as app"
  useradd ${app_user}
  rm -rf /app
  mkdir /app
  func_checking_status $?
  func_print_head "downlaod file "
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
  func_checking_status $?
  func_print_head "unzip the file"
  cd /app
  unzip /tmp/${component}.zip
  func_checking_status $?
  func_print_head "install npm "
  npm install
  func_print_head "copy ${component} services "
  cp /root/roboshop-shell/${component}.service /etc/systemd/system/${component}.service
  func_checking_status $?
  func_print_head "start services "
  systemctl daemon-reload
  systemctl enable ${component}
  systemctl start ${component}
  func_schema_setup
  func_checking_status $?
}
func_java()
{
  yum install maven -y
   func_print_head  "add user and directory(app)"

  useradd ${app_user}
  rm -rf /app
  mkdir /app
   func_print_head "Download app content "

  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
func_checking_status $?
  " unzip/extract app content the file"
  cd /app
  unzip /tmp/${component}.zip

   func_print_head "download maven dependencies"
func_checking_status $?
  mvn clean package
  mv target/${component}-1.0.jar ${component}.jar
  func_print_head " install mysql and load the schema "
  cp /root/roboshop-shell/${component}.service /etc/systemd/system/${component}.service
  func_checking_status $?
 func_print_head " start services "
  systemctl enable ${component}
  systemctl start ${component}
  func_checking_status $?
func_print_head " icalling inner function schema setup "
 func_schema_setup
 func_checking_status $?
 func_print_head "restart the " ${component}
  systemctl restart ${component}
  func_checking_status $?
}
func_payment()
{
  func_print_head "install python "
  yum install python36 gcc python3-devel -y
  func_checking_status $?
 func_print_head " Add application user "
  useradd ${app_user}
  rm -rf /app
  mkdir /app
  func_checking_status $?
  func_print_head " Download the app content"
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
  func_checking_status $?
 func_print_head " install maven "
  cd /ap
  unzip /tmp/${component}.zip
  func_checking_status $?
 func_print_head " install dependencies "
  pip3.6 install -r requirements.txt
  func_checking_status $?
  func_print_head " start services "
func_checking_status $?
  sed -i -e "s|payment_app_user_password|${payment_app_user_password}|" ${script_path}/${component}.service

func_checking_status $?
  cp /root/roboshop-shell/${component}.service /etc/systemd/system/${component}.service
 func_print_head "start payment services"
  systemctl daemon-reload
  systemctl enable ${component}
  systemctl start ${component}
  func_checking_status $?
}




