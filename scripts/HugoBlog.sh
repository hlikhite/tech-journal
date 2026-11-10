#!/bin/bash

# Custom scrip to install Apache, update Firewall for port 80 and 443, and set up a Hugo blog with customized entries using a gallery module that generates the HTML

# NOTE: run as root


# end if error occurs
set -e

# add http (80) and https (443) in and outbound the firewall permanently
firewall-cmd --add-service=http --add-service=https --permanent && firewall-cmd --reload

# install apache and modules needed for blog software
dnf install -y httpd tar

# set httpd to run on start and start httpd
systemctl enable httpd && systemctl start httpd

# install Hugo
curl -L https://github.com/gohugoio/hugo/releases/download/v0.169.0/hugo_extended_0.169.0_linux-amd64.tar.gz | tar xz -C /usr/bin hugo
rm -rf /home/hazel/blog # deletes previous Hugo blog so no errors can occur throughout blog iterations

# Create Huge blog in /home/hazel/blog
hugo new site /home/hazel/blog
cd /home/hazel/blog

# downloads gallery theme for hugo
curl -L https://github.com/nicokaiser/hugo-theme-gallery/archive/refs/tags/v4.9.3.tar.gz | tar xz -C themes
mv themes/hugo-theme-gallery-* themes/gallery

# Gallery instructions
echo "theme = 'gallery'" >> hugo.toml
sed -i "s/My New Hugo Project/Hazel Blog/" hugo.toml
echo "\n[[menus.main]]\nname = 'Hugo'\nurl = 'https://gohugo.io/'\n" >> hugo.toml
cp -r /home/hazel/memes /home/hazel/animals content/
echo '{"title":"Memes"}' > content/memes/index.md
echo '{"title":"Animals"}' > content/animals/index.md
echo '{"title":"Hazel Blog","description":"I built this blog with <a href=\"https://gohugo.io/\">Hugo</a> and Apache using a bash script. Scripting is more fun than coding."}' > content/_index.md
# If blog entries are required:
echo '{"title":"Entry One","menus":"main"}' > content/post1.md
echo 'I built this blog with Hugo and Apache using a bash script. Scripting is more fun than coding.' >> content/post1.md

# generates gallery
hugo -d /var/www/html
restorecon -R /var/www/html
echo "Done"

