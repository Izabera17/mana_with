#!/bin/sh

# Railsをインストール
gem install rails -v 6.1.4

# Node.js, Yarnをインストール
npm install -g yarn

# ImageMagickをインストール
sudo yum -y install libpng-devel libjpeg-devel libtiff-devel libxml2-devel gcc
cd
git clone https://github.com/ImageMagick/ImageMagick.git ImageMagick-7.1.0-5
cd ImageMagick-7.1.0-5
./configure
make
sudo make install
cd

# SQLiteをインストール
wget https://www.sqlite.org/2021/sqlite-autoconf-3360000.tar.gz
tar xzvf sqlite-autoconf-3360000.tar.gz
cd sqlite-autoconf-3360000/
./configure --prefix=/opt/sqlite/sqlite3
make
sudo make install
/opt/sqlite/sqlite3/bin/sqlite3 --version
gem pristine --all
gem install sqlite3 -- --with-sqlite3-include=/opt/sqlite/sqlite3/include --with-sqlite3-lib=/opt/sqlite/sqlite3/lib
echo 'export LD_LIBRARY_PATH="/opt/sqlite/sqlite3/lib"' >> ~/.bash_profile
