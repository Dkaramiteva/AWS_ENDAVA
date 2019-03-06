#!/bin/bash
echo -e "\e[33m ========= AWS Automation Project =========\033[0m"

#AWS variables - Modify these as per your account
# Enter your VPC ID
vpc_id="vpc-781ca702"

# Enter your Subnet ID.
sub_id="subnet-0c781350"

#Enter your route table ID - Optional
#route_table="rtb-12345"

#Enter internet gateway - Optional
#internet_gateway="igw-12345"

# Enter your security group ID
sec_id="sg-0c2306136ca78a2e1"

# Enter the AWS Image ID you would like to deploy. The below image ID is for an Ubuntu EC2 instance.
aws_image_id="ami-0ac019f4fcb7cb7e6"

#Set the type of instance you would like. Here, I am specifying a T2 micro instance.
i_type="t2.micro"

# Create an optional tag.
tag="DAYANA"

#Create the key name what you want
aws_key_name="edno-key"
ssh_key="edno-key.pem"

#Generate a random id - This is optional
uid=$RANDOM

# Generate AWS Keys and store in this local box
echo "Generating key Pairs"
aws ec2 create-key-pair --key-name edno-key --query 'KeyMaterial' --output text 2>&1 | tee $ssh_key

#Set read only access for key
echo "Setting permissions"
chmod 400 $ssh_key

echo "Creating EC2 instance in AWS"
#echo "UID $uid"

ec2_id=$(aws ec2 run-instances --image-id $aws_image_id --count 1 --instance-type $i_type --key-name $aws_key_name --security-group-$sub_id --associate-public-ip-address --tag-specifications 'ResourceType=instance,Tags=[{Key=WatchTower,Value="$tag"},{Key=Automatedp InstanceId | cut -d":" -f2 | cut -d'"' -f2)

# Log date, time, random ID
date >> logs.txt
#pwd >> logs.txt
echo $ec2_id >> logs.txt
echo ""

echo "EC2 Instance ID: $ec2_id"
#echo "Unique ID: $uid"
database_ip=$(aws ec2 describe-instances --instance-ids $ec2_id --query 'Reservations[0].Instances[0].PublicIpAddress' | cut -d'"' -

mysql_private_ip=$(aws ec2 describe-instances --instance-ids $ec2_id --query 'Reservations[0].Instances[0].PrivateIpAddress' | cut -

echo -e "Elastic IP: $database_ip"
echo $database_ip >> logs.txt
echo "=====" >> logs.txt

#echo "Copy paste the following command from this machine to SSH into the AWS EC2 instance"
#echo ""
#echo -e "\e[32m ssh -i $ssh_key ubuntu@$database_ip\033[0m"
echo ""
countdown_timer=60
echo "Please wait while your instance is being powered on..We are trying to ssh into the EC2 instance"
echo "Copy/paste the below command to acess your EC2 instance via SSH from this machine. You may need this later"
echo ""
echo "\033[0;31m ssh -i $ssh_key ubuntu@$database_ip\033[0m"

temp_cnt=${countdown_timer}
while [[ ${temp_cnt} -gt 0 ]];
do
printf "\rYou have %2d second(s) remaining to hit Ctrl+C to cancel that operation!" ${temp_cnt}
sleep 1
((temp_cnt--))
done
echo ""

ssh -i $ssh_key ubuntu@$database_ip '

sudo apt-get update
sudo apt-get install mysql-server
echo MYSQL INSTALLED SUCCESSFULY
sudo systemctl start mysql
echo STARTED SUCCESSFULLY
sudo ufw allow mysql
sudo systemctl enable mysql
sudo chmod 777 /etc/mysql/my.cnf

sudo echo "bind-address=$(hostname -I)" >> /etc/mysql/my.cnf

echo AFTER BIND ADDRESS ADDED

exit;'

echo "---The creation of the database and granting of the privileges require the private ip of the apache vm, and that's why they aredure!---"

echo "-------------Creating second instance--------------"


#Create the key name what you want
aws_key_name2="dve-key"
ssh_key2="dve-key.pem"

#Generate a random id - This is optional
uid2=$RANDOM

# Generate AWS Keys and store in this local box
echo "Generating key Pairs"
aws ec2 create-key-pair --key-name dve-key --query 'KeyMaterial' --output text 2>&1 | tee $ssh_key2

#Set read only access for key
echo "Setting permissions"
chmod 400 $ssh_key2

echo "Creating EC2 instance in AWS"
#echo "UID $uid2"

ec2_id2=$(aws ec2 run-instances --image-id $aws_image_id --count 1 --instance-type $i_type --key-name $aws_key_name2 --security-groud $sub_id --associate-public-ip-address --tag-specifications 'ResourceType=instance,Tags=[{Key=WatchTower,Value="$tag"},{Key=Automatgrep InstanceId | cut -d":" -f2 | cut -d'"' -f2)

# Log date, time, random ID
date >> logs.txt
#pwd >> logs.txt
echo $ec2_id2 >> logs.txt
echo ""

echo "EC2 Instance ID: $ec2_id2"
#echo "Unique ID: $uid2"
web_ip=$(aws ec2 describe-instances --instance-ids $ec2_id2 --query 'Reservations[0].Instances[0].PublicIpAddress' | cut -d'"' -f2)

web_private_ip=$(aws ec2 describe-instances --instance-ids $ec2_id2 --query 'Reservations[0].Instances[0].PrivateIpAddress' | cut -d

echo -e "Elastic IP: $web_ip"
echo $web_ip >> logs.txt
echo "=====" >> logs.txt

#echo "Copy paste the following command from this machine to SSH into the AWS EC2 instance"
#echo ""
#echo -e "\e[32m ssh -i $ssh_key2 ubuntu@$web_ip\033[0m"
echo ""
countdown_timer=60
echo "Please wait while your instance is being powered on..We are trying to ssh into the EC2 instance"
echo "Copy/paste the below command to acess your EC2 instance via SSH from this machine. You may need this later"
echo ""
echo "\033[0;31m ssh -i $ssh_key2 ubuntu@$web_ip\033[0m"

temp_cnt=${countdown_timer}
while [[ ${temp_cnt} -gt 0 ]];
do
printf "\rYou have %2d second(s) remaining to hit Ctrl+C to cancel that operation!" ${temp_cnt}
sleep 1
((temp_cnt--))
done
echo ""

ssh -i $ssh_key2 ubuntu@$web_ip '
sudo apt update
sudo apt install apache2
sudo apt install php
sudo apt install libapache2-mod-php
sudo apt-get update
sudo apt-get install mysql-server php7.2-mysql

sudo chmod 777 /var/www/html
'

echo "CREATE DATABASE prices; CREATE USER 'db_user_1' IDENTIFIED BY 'goal5Zhia'; GRANT ALL PRIVILEGES ON prices.* to db_user_1@$web_ 'goal5Zhia'; FLUSH PRIVILEGES; USE prices; CREATE TABLE metals (name VARCHAR(100), price_usd_lb DOUBLE); INSERT INTO metals VALUES INTO metals VALUES ('tin',13.6305); INSERT INTO metals VALUES ('copper',4.0531);" | ssh -i $ssh_key ubuntu@$database_ip "sudo mysql"

echo 'sudo service mysql restart' | ssh -i $ssh_key ubuntu@$database_ip

sudo sed "s/paste_ip_here/$mysql_private_ip/g" template.php > simple_web_app.php
sudo rsync -avzL -e "ssh -i dve-key.pem -p 22" ./simple_web_app.php  ubuntu@$web_ip:/var/www/html
echo 'sudo service apache2 restart' | ssh -i $ssh_key2 ubuntu@$web_ip
