t_time=`date '+%Y-%m-%d-%H-%M-%S'`
database=$1
mode=$2
host='127.0.0.1'
db_user='root'
db_pass='123456'


dump_all_data(){
echo "导出全部数据和结构"

mysql -h $host -e "show databases;" -u $db_user  -p$db_pass | grep -Ev "Database|information_schema|mysql|performance_schema" | xargs mysqldump -h $host -u $db_user  -p$db_pass  --databases |gzip > $database_${t_time}.sql.gz
echo $database_${t_time}.sql.gz > args
}


dump_all_struct(){
echo "只导出全部数据结构"
mysql -h $host -e "show databases;" -u $db_user  -p$db_pass | grep -Ev "Database|information_schema|mysql|performance_schema" | xargs mysqldump -h $host -u $db_user  -p$db_pass  -d --databases |gzip > $database_${t_time}.sql.gz

}

dump_single_db_all(){
echo "导出单个数据库"
mysqldump  -h $host $database -u $db_user -p$db_pass |gzip > $database_${t_time}.sql.gz

}

dump_single_db_struct(){
echo "导出单个数据库结构"
mysqldump  -h $host -d $database -u $db_user -p$db_pass  |gzip > $database_${t_time}.sql.gz
}



if [ $database == 'all' ]
then
    if [ $mode == '1' ]
        then
        dump_all_data   #导出数据库
    else
        dump_all_struct #只导出结构
    fi
else
    if [ $mode == '1' ]
        then
        dump_single_db_all
    else
        dump_single_db_struct
    fi

fi

