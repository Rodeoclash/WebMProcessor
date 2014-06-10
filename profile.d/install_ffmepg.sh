#!bin/bash

# build into this folder
mkdir ~/src

# yasm
cd ~/src
git clone git://github.com/yasm/yasm.git
cd yasm
git checkout v1.2.0
./autogen.sh
make
make install

# libogg
cd ~/src
wget http://downloads.xiph.org/releases/ogg/libogg-1.3.0.tar.gz
tar xzvf libogg-1.3.0.tar.gz
cd libogg-1.3.0
./configure --disable-shared
make
make install

# libvorbis
cd ~/src
wget http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.3.tar.gz
tar xzvf libvorbis-1.3.3.tar.gz
cd libvorbis-1.3.3
./configure --disable-shared
make
make install

# libvpx
cd ~/src
git clone http://git.chromium.org/webm/libvpx.git
cd libvpx
./configure
make
make install

# ffmpeg
cd ~/src
git clone git://source.ffmpeg.org/ffmpeg.git
cd ffmpeg
./configure --enable-libvpx --enable-libvorbis
make
make install