echo -e "\e[36m install nginx server \e[0m"
dnf install nginx -y

echo -e "\e[36m copy file to expense conf \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf

echo -e "\e[36m enable nginx server \e[0m"
systemctl enable nginx

echo -e "\e[36m start nginx server \e[0m"
systemctl start nginx

echo -e "\e[36m remove old html files in nginx server \e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[36m downloading frontend zip file \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip

echo -e "\e[36m unzip the frontend file \e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

echo -e "\e[36m restart nginx server \e[0m"
systemctl restart nginx