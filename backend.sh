echo -e "\e[36m disable node js 10 \e[0m"
dnf module disable nodejs -y

echo -e "\e[36m enable nodejs 18 \e[0m"
dnf module enable nodejs:18 -y &>/temp/expense.log

echo -e "\e[36m copy backend services \e[0m"
cp backend.service /etc/systemd/system/backend.service &>/temp/expense.log

echo -e "\e[36m install nodejs \e[0m"
dnf install nodejs -y &>/temp/expense.log

echo -e "\e[36m add a user \e[0m"
useradd expense &>/temp/expense.log

echo -e "\e[36m make a directory \e[0m"
mkdir /app &>/temp/expense.log

echo -e "\e[36m downloading the files \e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>/temp/expense.log
cd /app &>/temp/expense.log

echo -e "\e[36m unzip the files \e[0m"
unzip /tmp/backend.zip &>/temp/expense.log

echo -e "\e[36m install npm \e[0m"
npm install &>/temp/expense.log

systemctl daemon-reload &>/temp/expense.log

systemctl enable backend &>/temp/expense.log
systemctl start backend &>/temp/expense.log

dnf install mysql -y &>/temp/expense.log

mysql -h 172.31.41.104 -uroot -pExpenseApp@1 < /app/schema/backend.sql