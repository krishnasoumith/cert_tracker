#!/bin/bash
#sudo su
docker exec -d web sh /usr/local/tomcat/webapps/prodcert/script.sh
sleep 2
#//Path to store the certs, create folder to store the certs and update the path below
Path=/home/rxadmin/cert_tracker/certificates
docker cp web:/usr/local/tomcat/webapps/prodcert/uploadFiles/. $Path
ls -lt $Path/*crt $Path/*.pem | cut -d ":" -f 2 | cut -d " " -f 2 | cut -d "/" -f 6 > "$Path/prod_certificates" 2>/dev/null
#next_month_date=`TZ=GMT date -d next-month +"%b %d %H:%m:%S %Y %Z"`
new_date=`TZ="US/Central" date '+%Y-%m-%d'`
echo "New Date"
echo "$new_date"
#next_date=$(date -d "${next_month_date}" "+%s")
new_date_value=$(date -d "${new_date}" "+%s")
echo "new_date_value"
echo "$new_date_value"
#echo "New -$new_date"
#echo "New 1-$new_date_1"

cd $Path
rm file.csv
while read -r line; do
    echo "working on $line"
    expiry_date=`openssl x509 -text -noout -in "$line" | grep -i after | cut -d ":" -f 2-4 |sed 's/^ *//'`
    echo "Expiry date - $expiry_date"
    expiry_date_value=$(date -d "${expiry_date}" "+%s")
    echo "expiry_date_value"
    echo "$expiry_date_value"
    expiry_date2=`(TZ=":US/Central" date --date="$expiry_date" '+%Y-%m-%d')`
#    echo "$expiry_date2"
    remaining_days=$((($expiry_date_value - $new_date_value) / 86400 ))
     echo "remaining_days"
     echo "$remaining_days"
#     echo "${line},${expiry_date2},${remaining_days}" >> file.csv
#    echo "Expiry date new - $expiry_date1"
    if [ ${expiry_date_value} -le ${new_date_value} ];
    then
        status=EXPIRED
    else
        status=VALID
    fi
    echo "$status"
    echo "${line},${expiry_date2},${remaining_days}, ${status}" >> file.csv
done < "prod_certificates"
docker cp /home/rxadmin/certificates/file.csv db:/opt/test/
docker exec -d db sh /opt/test/script.sh

