#!/usr/bin/bash
Path=/home/rxadmin/cert_tracker/certificates
EMAIL=Soumithdevops1@gmail.com
ls -lt $Path/*.crt $Path/*.pem | cut -d ":" -f 2 | cut -d " " -f 2 | cut -d "/" -f 6 > "$Path/cert_notification" 2>/dev/null
#next_month_date=`TZ=GMT date -d next-month +"%b %d %H:%m:%S %Y %Z"`
new_date=`TZ=GMT date -d "+45 days"  +"%b %d %H:%m:%S %Y %Z"`
#next_date=$(date -d "${next_month_date}" "+%s")
next_date=$(date -d "${new_date}" "+%s")
#echo "Next month date -$next_month_date"
#echo "Next date -$next_date"
#echo "New -$new_date"
#echo "New 1-$new_date_1"

cd $Path
while read -r line; do
    #echo "working on $line"
    expiry_date=`openssl x509 -text -noout -in "$line" | grep -i after | cut -d ":" -f 2-4 |sed 's/^ *//'`
    #echo "Expiry date - $expiry_date"
    expiry_date1=$(date -d "${expiry_date}" "+%s")
    #echo "Expiry date new - $expiry_date1"
    if [ ${expiry_date1} -le ${next_date} ];
    then
       echo "insde if++++++++++++++"
       echo "Certificate is about to expire for $line, please renew the certificate. Certificate expiry date is $expiry_date" | mail -s "Certificate about to expire for $line" $EMAIL
    fi
done < "cert_notification"
#rm cert_notification
