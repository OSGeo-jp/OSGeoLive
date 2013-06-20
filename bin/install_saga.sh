#!/bin/sh
#
# install_saga.sh
# 
#
# Created by Johan Van de Wauw on 2010-07-02
# Copyright (c) 2009 The Open Source Geospatial Foundation.
# Licensed under the GNU LGPL.
# lucid: saga 2.0.4 is provided in ubuntugis and ubuntugis/unstable

SCRIPT="install_saga.sh"
echo "==============================================================="
echo "$SCRIPT"
echo "==============================================================="

if [ -z "$USER_NAME" ] ; then
   USER_NAME="user"
fi
USER_HOME="/home/$USER_NAME"

#Temporary towards the svn build ppa until 2.1.0 is definitely released
add-apt-repository --yes ppa:johanvdw/sagacvs

apt-get -q update
apt-get --assume-yes install saga libsaga

# Additional documentation
mkdir -p /usr/local/share/saga
cd /usr/local/share/saga

# Demo dataset
wget -N --progress=dot:mega \
  http://zadeh.ugent.be/~johan/saga/DGM_30m_Mt.St.Helens_SRTM.grd
# Link demo dataset to user_home
ln -s /usr/local/share/saga "$USER_HOME"/saga
ln -s /usr/local/share/saga /etc/skel/saga


# Desktop icon
# temporarily disabled: a custom .desktop file with a 64x64 logo is used - to be fixed in the package
wget -nv http://zadeh.ugent.be/~johan/saga/saga_gui_64x64.png \
   --output-document=/usr/share/pixmaps/saga_gui_64x64.png
wget -nv http://zadeh.ugent.be/~johan/saga/saga_gui.desktop \
   --output-document=/usr/share/applications/saga_gui.desktop

cp /usr/share/applications/saga_gui.desktop "$USER_HOME/Desktop/"
chown "$USER_NAME:$USER_NAME" "$USER_HOME/Desktop/saga_gui.desktop"

echo "==============================================================="
echo "Finished $SCRIPT"
echo Disk Usage1:, $SCRIPT, `df . -B 1M | grep "Filesystem" | sed -e "s/  */,/g"`, date
echo Disk Usage2:, $SCRIPT, `df . -B 1M | grep " /$" | sed -e "s/  */,/g"`, `date`
echo "==============================================================="