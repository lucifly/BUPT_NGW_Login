#!/bin/sh

#-----------------------------------------#
# siwind 编写。QQ: 35949934
# LOOK 改编。
# 2019.08.29 @N 修改
# 校园网网关更改，做对应调整
#-----------------------------------------#
# Usage : logbuptgw [-i|-o] [username] [password]
# Before Use This, Please Make Sure That The 
# Below Has Been Done And Tool "curl" Has Been 
# Installed.(Installation: #apt-get install curl)
#
# #cp logbuptgw.sh /usr/bin/logbuptgw
# #chmod +x /usr/bin/logbuptgw
#-----------------------------------------#

# URL_LOGIN=http://gw.bupt.edu.cn
# URL_LOGOUT=http://gw.bupt.edu.cn/F.htm
URL_LOGIN=http://10.3.8.211/login
URL_LOGOUT=http://10.3.8.211/logout

login()
{
	USERNAME=$1
	PASSWD=$2
	tmp="1"$PASSWD"12345678"
	upass=`echo -n $tmp|md5sum|cut -d ' ' -f1`
	upass=$upass"123456781"
	echo login...
	# RESULT=`curl --silent -d "DDDDD=$USERNAME&upass=$upass&R1=0&R2=1&para=00&0MKKey=123456" "$URL_LOGIN"`
	RESULT=`curl --silent -d "user=$USERNAME&pass=$PASSWD&line=" "$URL_LOGIN"`
	echo login OK!
}

logout()
{
	echo logout...
	RESULT=`curl --silent "$URL_LOGOUT"`
	echo logout OK!
}

usage()
{	
	echo "Usage: $0 [-i|-o] [UserName] [PassWord]"
	echo "where:		-i [UserName] [PassWord] login to bupt school network"
	echo "		-o logout from bupt school network"
	echo 
	exit
}

if [ $# -lt 1 ] ; then
	usage
fi

case $1 in
-i)
	if [ $# -lt 3 ]; then
		usage
	fi
	UsrName=$2
	PsWd=$3
	login $UsrName $PsWd ;;
-o)
	logout;;
*)
	usage;;
esac
