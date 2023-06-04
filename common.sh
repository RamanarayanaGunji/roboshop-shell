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

func_Schema_setup()
{
  if[${schema_setup}=mongo];
  then
    func_print_head "copy the file"
     cp /root/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo
     func_print_head "install mongodb "
     yum install mongodb-org-shell -y
     func_print_head" changing mongo ip address "
     mongo --host mongodb.devopsb72r.online </app/schema/user.js
  fi
}

func_nodejs()
{
  func_print_head "open node source"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash
  func_print_head "install node js"
  yum install nodejs -y

  func_print_head "add user as roboshop and creat directoty as app"
  useradd ${app_user}
  rm -rf /app
  mkdir /app
  func_print_head "downlaod file "
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
  func_print_head "unzip the file"
  cd /app
  unzip /tmp/${component}.zip
  func_print_head "install npm "
  npm install
  func_print_head "copy ${component} services "
  cp /root/roboshop-shell/${component}.service /etc/systemd/system/${component}.service
  func_print_head "start services "
  systemctl daemon-reload
  systemctl enable ${component}
  systemctl start ${component}
  func_Schema_setup
}




