#!/bin/bash

# macOS change <computername> here and in launcher; then add launcher to startup
# add to (sudo nano /etc/rc.local in linux)
#screen -dmS cl -L /Users/<computername>/Library/Mobile\ Documents/com\~apple\~CloudDocs/DEV/cloud_logger/cloud_logger

sleep 5

COMPUTER_NAME="macpro_m1"
CLOUD_LOG()
{
BULLET="${OUT_CL}"
MSG="nuvyryifevyibabfavybyzbujovyofp_yocoybobiovojifowojsetoghuolyoo_obenzigfuancecihbaikleenohjecch"
AUTH="${MSG}"
OUTPUT_LINE="$OVERLORD/cloud_logger/$TIME"
echo -e "\n\n$BULLET\n\n$OUTPUT_LINE\n\n"
/usr/bin/curl -X POST --output /dev/null $OUTPUT_LINE --header "Authorization: $AUTH" --header "Content-Type: application/json" -d "$BULLET"
}

OVERLORD="https://openrig.net"
TEST=0
INIT=0
TIME=$(date +%H%M%S)
DAY=$(date +%F)
NETWORKUP="NO"
NAME="logon_on_${DAY}_at_${TIME}_.txt"
NETFAIL=0
ITR=0
main()
{
test=$(ifconfig -a inet 2>/dev/null | sed -n -e '/127.0.0.1/d' -e '/0.0.0.0/d' -e '/inet/p' | wc -l)
if [ "${test}" -gt 0 ]; 
then
NETWORKUP="YES"
fi

# if macOS
if [[ $INIT == 0 ]]
then
OUT="boot on $DAY at $TIME\n\nInternet connected: $NETWORKUP"
OUT_CL="boot on $DAY at $TIME  Internet connected: $NETWORKUP"
#EXPORT=$(echo -e $OUT | nc termbin.com 9999)
CLOUD_LOG
#REC="\n$OUT\n\n$EXPORT\n"
REC="\n$OUT\n"
cd /Users/$COMPUTER_NAME/Library/Mobile\ Documents/com\~apple\~CloudDocs/DEV/cloud_logger
echo -e $REC > $NAME
INIT=1
echo -e $REC
fi ## [[ $INIT == 0 ]]

# if macOS
if [[ $NETWORKUP == "NO" || $TEST == 1 ]]
then
NETFAIL=$(($NETFAIL+1))
TIME=$(date +%H%M%S)
DAY=$(date +%F)
NET="netfail_at_${TIME}_on_$DAY.txt"
OUT="Internet connected: $NETWORKUP\n\nNETWORK DOWN at $TIME on $DAY\n\nNETFAIL: $NETFAIL"
REC="\n$OUT\n"
cd /Users/$COMPUTER_NAME/Library/Mobile\ Documents/com\~apple\~CloudDocs/DEV/cloud_logger
echo -e $REC > $NET
echo -e $REC
fi ## if [[ $NETWORKUP == "NO" || $TEST == 1 ]]
ITR=$(($ITR+1))
}

main

DIR=/Volumes/ramdisk
[[ -d "$DIR" ]] || diskutil erasevolume HFS+ 'ramdisk' `hdiutil attach -nomount ram://8388608`
#while [ 1 ]
#do
#sleep 60
#main
#echo -e "\n$ITR\n"
#done
#fi
