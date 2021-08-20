#!/bin/bash
for pfx in $(ls /usr/local/tomcat/webapps/prodcert/uploadFiles/*.pfx)
do
	cert=`ls -lt /usr/local/tomcat/webapps/prodcert/uploadFiles/*.pfx | cut -d " " -f 9 | cut -d "/" -f 8 | awk -F".pfx" '{print $1}'`
	echo "$cert"
	`openssl pkcs12 -in $pfx -out /usr/local/tomcat/webapps/prodcert/uploadFiles/"$cert".pem -nodes -passin pass:`
	rm /usr/local/tomcat/webapps/prodcert/uploadFiles/"$cert".pfx
done

#cp /usr/local/tomcat/webapps/prodcert/uploadFiles/*.pem ~/automation/prod_cert/

#rm /usr/local/tomcat/webapps/prodcert/uploadFiles/*.pem
