log_file = /tmp/expense.log
echo -e "\e[36m install nginx server \e[0m"
dnf install nginx -y  >log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo -e "\e[31m FAILURE \e[0m"
fi

echo -e "\e[36m copy file to expense conf \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf >log_file
if  [ $? -eq 0 ]; then
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo -e "\e[31m FAILURE \e[0m"
fi

echo -e "\e[36m enable nginx server \e[0m"
systemctl enable nginx >log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo -e "\e[31m FAILURE \e[0m"
fi

echo -e "\e[36m start nginx server \e[0m"
systemctl start nginx >log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo -e "\e[31m FAILURE \e[0m"
fi

echo -e "\e[36m remove old html files in nginx server \e[0m"
rm -rf /usr/share/nginx/html/* >log_file
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo -e "\e[31m FAILURE \e[0m"
fi

echo -e "\e[36m downloading frontend zip file \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo -e "\e[31m FAILURE \e[0m"
fi

echo -e "\e[36m unzip the frontend file \e[0m"
cd /usr/share/nginx/html >log_file
unzip /tmp/frontend.zip >log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo -e "\e[31m FAILURE \e[0m"
fi

echo -e "\e[36m restart nginx server \e[0m"
systemctl restart nginx >log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo -e "\e[31m FAILURE \e[0m"
fi
