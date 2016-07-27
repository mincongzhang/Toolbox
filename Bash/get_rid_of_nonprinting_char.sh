#-i inplace
sed -i 's/[\d128-\d255]//g' FILENAME

#For a string var
symbol=$(tr -dc '[[:print:]]' <<< "$symbol")
