# https://www.effectiveperlprogramming.com/2010/04/when-perl-isnt-enough/

$trans = "Hello, today is `date +%Y%m%d`, yesterday is `date --date=\"-1 day\" +%Y%m%d`!";
$result = qx{echo "$trans"};
print $result;
