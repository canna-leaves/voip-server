#!/bin/sh
WORK_DIR=$(pwd)
DOWNLOAD_DIR=/root/.download
FREESWITCH_DIR=$WORK_DIR/freeswitch-1.6.20

download () {
	if [ ! -d  $DOWNLOAD_DIR ];then mkdir $DOWNLOAD_DIR;fi; \
	if [ -f $DOWNLOAD_DIR/$2.tmp ];then rm $DOWNLOAD_DIR/$2.tmp;fi; \
	if [ ! -f $DOWNLOAD_DIR/$2 ] ;then \
		echo "download "$2; \
		if [ -x /usr/bin/wget ];then wget -O $DOWNLOAD_DIR/$2.tmp $3; \
		else echo "please install wget";fi;fi; \
	if [ -f $DOWNLOAD_DIR/$2.tmp ];then mv $DOWNLOAD_DIR/$2.tmp $DOWNLOAD_DIR/$2;fi; \
	if [ -f $DOWNLOAD_DIR/$2 ] && [ ! -d $1 ];then \
		echo "unpack "$2; \
		if [ "tar.gz" = ${2:0-6:6} ];then tar xzf $DOWNLOAD_DIR/$2;fi; \
		if [ "tar.bz2" = ${2:0-7:7} ];then tar xjf $DOWNLOAD_DIR/$2;fi; \
		if [ "zip" = ${2:0-3:3} ];then unzip $(DOWNLOAD_DIR)/$2;fi; \
	fi;
}

download_source() {
    download . docker-compose-Linux-x86_64 "https://github.com/docker/compose/releases/download/1.21.2/docker-compose-Linux-x86_64"
	download $FREESWITCH_DIR freeswitch-1.6.20.tar.gz "http://files.freeswitch.org/releases/freeswitch/freeswitch-1.6.20.tar.gz"
    if [ ! -h /usr/bin/docker-compose ];then chmod +x $DOWNLOAD_DIR/docker-compose-Linux-x86_64; \
        ln -sf $DOWNLOAD_DIR/docker-compose-Linux-x86_64 /usr/bin/docker-compose;fi
}

build() {
    docker-compose build
}

start() {
    docker-compose up -d
}

restart() {
    docker-compose restart
}

case "$1" in
  all)
    download_source
    start
	;;
  download)
    download_source
	;;
  build)
    build
	;;
  start)
    start
	;;
  restart)
    restart
	;;
  *)
	echo "Usage: download.sh {all|download|build|start|restart}"
esac

exit $?

