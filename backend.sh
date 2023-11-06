echo -e "\e[36m disable node js 10 \e[0m"
dnf module disable nodejs -y &>/tmp/expense.log

echo -e "\e[36m enable nodejs 18 \e[0m"
dnf module enable nodejs:18 -y &>/tmp/expense.log

echo -e "\e[36m copy backend services \e[0m"
cp backend.service /etc/systemd/system/backend.service &>>/tmp/expense.log

echo -e "\e[36m install nodejs \e[0m"
dnf install nodejs -y &>>/tmp/expense.log

echo -e "\e[36m add a user \e[0m"
useradd expense &>>/tmp/expense.log

echo -e "\e[36m make a directory \e[0m"
mkdir /app &>/tmp/expense.log

echo -e "\e[36m downloading the files \e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>/tmp/expense.log
cd /app &>/tmp/expense.log

echo -e "\e[36m unzip the files \e[0m"
unzip /tmp/backend.zip &>/tmp/expense.log

echo -e "\e[36m install npm \e[0m"
npm install &>/tmp/expense.log

systemctl daemon-reload &>/tmp/expense.log

systemctl enable backend &>/tmp/expense.log
systemctl start backend &>/tmp/expense.log

dnf install mysql -y &>/tmp/expense.log

mysql -h 172.31.41.104 -uroot -pExpenseApp@1 < /app/schema/backend.sql &>/tmp/expense.log