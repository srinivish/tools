#!/bin/bash
echo "START" | systemd-cat -t startup_script -p 4
# Update package index
sudo apt update
echo "Install Apache" | systemd-cat -t startup_script -p 4
# Install Apache
sudo apt install -y apache2

# Start Apache service
echo "Start Apache service" | systemd-cat -t startup_script -p 4
sudo systemctl start apache2

# Enable Apache service to start on boot
sudo systemctl enable apache2
echo "create custom index.html page" | systemd-cat -t startup_script -p 4

# Create custom index.html page
cat <<EOF | sudo tee /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to My Website</title>
</head>
<body>
    <h1>Welcome to My Website</h1>
    <p>This is a custom index.html page.</p>
    <p><strong>Hostname:</strong>$(hostname)</p>
    <p><strong>IP_Address:</strong>$(hostname -i|cut -d " " -f 1)</p>
</body>
</html>
EOF

# Restart Apache to apply changes
echo "restarting Apache" | systemd-cat -t startup_script -p 4

sudo systemctl restart apache2

echo "Apache installed and configured successfully!" | systemd-cat -t startup_script -p 4

# install git
echo "Install git" | systemd-cat -t startup_script -p 4
sudo apt install git -y

echo "END" | systemd-cat -t startup_script -p 4
