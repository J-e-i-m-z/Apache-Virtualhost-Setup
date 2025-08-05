#!/bin/bash

# Update system
echo "Updating system packages .... "
sudo dnf update -y 

sudo dnf install -y httpd
sudo dnf enable --now httpd
sudo dnf start httpd
# sudo systemctl status httpd

# Configure firewall 
echo "Configuring Firewal .... "
sudo systemctl start firewalld
sudo systemctl enable firewalld

sudo firewall-cmd --permanent --zone=public --add-service=http
sudo firewall-cmd --permanent --zone=public --add-service=https
sudo firewall-cmd --reload

sudo vim /etc/httpd/conf/httpd.conf # Document Root /var/www/html # Listen 80
cd /var/www/html
sudo vim index.html

# Configure virtual hosts
sudo mkdir -p /var/www/site1.local/public_html
sudo mkdir -p /var/www/site2.local/public_html

# Set Apache (apache user and group) as the owner of the test-site-1 and test-site-2 directories
# Give read and execute permissions to everyone, but only allow the owner to write.
sudo chown -R apache:apache /var/www/site1.local/public_html /var/www/site2.local/public_html
sudo chmod -R 755 /var/www/site1.local/public_html /var/www/site2.local/public_html

# Create index.html file in:  sudo touch /var/www/site1.local/public_html/index.html
# Create index.html file in:  sudo touch /var/www/site2.local/public_html/index.html

# Edit the files:
#  sudo vim /var/www/site1.local/public_html/index.html
#  sudo vim /var/www/site2.local/public_html/index.html

# Create Virtual Host Configuration Files 
# Apache looks for virtual host configurations in /etc/httpd/conf.d/ by default and each domain will need its own configuration file.
sudo vim /etc/httpd/conf.d/site1.local.conf
sudo vim /etc/httpd/conf.d/site2.local.conf

<VirtualHost *:80>
    ServerAdmin support@example.com
    ServerName site1.local
    ServerAlias www.site1.local
    DocumentRoot /var/www/site1.local/public_html
    ErrorLog /var/log/httpd/site1.local-error.log
    CustomLog /var/log/httpd/site1.local-access.log combined
</VirtualHost>

# Test that the configuration is valid.
 sudo httpd -t  # or sudo apachectl configtest

# For local testing, add the following entries to your /etc/hosts file
# 127.0.0.1 test-site-1.local
# 127.0.0.1 test-site-2.local
sudo vim /etc/hosts


# Set a Global ServerName Directive
sudo vim /etc/httpd/conf/httpd.conf
# Add the ServerName 127.0.0.1 line to the end of the file
ServerName 127.0.0.1

# Reload/Restart Apache
sudo systemctl reload httpd # restart

#  Verify that Apache web server is running
sudo systemctl status httpd




