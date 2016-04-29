


Commands to build littlesis database and grand privileges


su – postgres
psql
create database littlesis



Download and untar csv files from the following Amazon s3 storage:

wget https://s3.amazonaws.com/littlesiscsv/littlesis_tar/littlesis_ddl_csv.tar

tar -xvf littlesis_ddl_csv.tar



psql -f /data/finaltables/createschema_littlesis.sql littlesis

psql -f /data/finaltables/copydata_littlesis.sql littlesis

psql -f /data/finaltables/transforming_data.sql littlesis



Create user w205 if doesn’t exist and grant privileges

psql -f /data/finaltables/grantprivileges_final.sql littlesis

