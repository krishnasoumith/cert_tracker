mysql -uroot -proot --local-infile cert_tracker << EOF;
SET GLOBAL local_infile = 1;
truncate table certificate;
LOAD DATA LOCAL INFILE '/opt/test/file.csv' INTO TABLE certificate fields terminated by ',';
EOF
