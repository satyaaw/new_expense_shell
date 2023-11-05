echo -e "\e[36m install nginx server \e[0m"
dnf install nginx -y  >/tmp/expense.log
if [$? -eq 0]; then
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo -e "\e[31m FAILURE \e[0m"

echo -e "\e[36m copy file to expense conf \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf >/tmp/expense.log
if [$? -eq 0]; then
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo -e "\e[31m FAILURE \e[0m"

echo -e "\e[36m enable nginx server \e[0m"
systemctl enable nginx >/tmp/expense.log
if [$? -eq 0]; then
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo -e "\e[31m FAILURE \e[0m"

echo -e "\e[36m start nginx server \e[0m"
systemctl start nginx >/tmp/expense.log
if [$? -eq 0]; then
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo -e "\e[31m FAILURE \e[0m"

echo -e "\e[36m remove old html files in nginx server \e[0m"
rm -rf /usr/share/nginx/html/* >/tmp/expense.log
if [$? -eq 0]; then
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo -e "\e[31m FAILURE \e[0m"

echo -e "\e[36m downloading frontend zip file \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>/tmp/expense.log
if [$? -eq 0]; then
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo -e "\e[31m FAILURE \e[0m"

echo -e "\e[36m unzip the frontend file \e[0m"
cd /usr/share/nginx/html >/tmp/expense.log
unzip /tmp/frontend.zip >/tmp/expense.log
if [$? -eq 0]; then
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo -e "\e[31m FAILURE \e[0m"

echo -e "\e[36m restart nginx server \e[0m"
systemctl restart nginx >/tmp/expense.log
if [$? -eq 0]; then
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo -e "\e[31m FAILURE \e[0m"