
# BEFORE ANSIBLE
#yum install nginx -y
#cp roboshop.conf /etc/nginx/default.d/roboshop.conf
#systemctl enable nginx
#systemctl start nginx
#rm -rf /usr/share/nginx/html/*
#curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
#cd /usr/share/nginx/html
#unzip /tmp/frontend.zip
#systemctl restart nginx

# WE HAVE BELOW CODE BEFORE START OF ANSIBLE

script =$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

func_print_head "Install Nginx"
yum install nginx -y & >> $log_file
func_stat_check $?

func_print_head
