cur_date=`date +'%Y%m%d'`
echo $cur_date
pre_date=`date +'%Y%m%d' -d "$cur_date-5 days"`
echo $pre_date
