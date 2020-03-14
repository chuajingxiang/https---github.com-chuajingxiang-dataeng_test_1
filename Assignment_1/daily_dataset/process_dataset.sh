#!/bin/bash
#************************************************************************************************************
# MODULE NAME       : process_dataset.sh
# MODULE DESCRIPTION: Section 1: Data Pipelines, using bash to do etl on csv source file.
#
#
# USAGE             : ./process_dataset.sh
# DATE CREATED      : 14 March 2020
# ORIGINAL AUTHOR   : Jing Xiang
#************************************************************************************************************
# MODIFICATION HISTORY
#************************************************************************************************************
# DATE MODIFIED         MODIFIED BY             COMMENTS
#************************************************************************************************************
# 
#************************************************************************************************************

#Could use a config file for neatness.
filename=dataset.csv
processed_filename='processed_'$filename
>$processed_filename
echo "first_name,last_name,price,above_100" > $processed_filename

sed -e 1d $filename | while IFS=, read -r name price
do
    cur_name=$name
	#trim title(eg. Mr. Mrs. Dr.)
    cur_name_without_title=`echo $cur_name | sed 's/Mrs.//g' | sed 's/Mr.//g' | sed 's/Dr.//g' | sed 's/Jr.//g'`
    cur_price=$price
	#Remove any zeros prepended to the price field
    cur_price_trimzero=`echo $cur_price | sed 's/^0*//' |sed 's/\r$//'`

    #Delete any rows which do not have a name
    if [ ! -z "$cur_name_without_title" ]
    then
	    #Split the name field into first_name, and last_name
        cur_firstname=`echo $cur_name_without_title | cut -d ' ' -f 1`
        cur_lastname=`echo $cur_name_without_title | cut -d ' ' -f 2`
		
        #Create a new field named above_100, which is true if the price is strictly greater than 100
        cur_pricecheck=`echo $cur_price_trimzero | cut -d '.' -f 1`
        if [[ $cur_pricecheck -gt 100 ]]
        then
            cur_above_check='true'
        else
            cur_above_check='false'
        fi

        echo ${cur_firstname},${cur_lastname},${cur_price_trimzero},"${cur_above_check}" >> $processed_filename

    fi 
done

