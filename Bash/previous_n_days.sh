cur_date=`date +'%Y%m%d'`
echo $cur_date
pre_date=`date +'%Y%m%d' -d "$cur_date-5 days"`
echo $pre_date

#also work
pre_date=`date +'%Y%m%d' -d "-5 days"`
echo $pre_date

#Or
pre_date=`date +'%Y%m%d' --date='-1 day'`
echo $pre_date

