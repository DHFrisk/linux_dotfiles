#!/bin/bash

#echo "Type the following parameters: path file_type file_name\nExample: ./find-script.sh /home/user/ jpg collected-paths";

echo -e "Type path to scan/find (eg. /home/user):\t"
read path
echo -e "Type file type you want to find (eg. jpg, png, iso, ods):\t"
read file_type
echo -e "Type your file name where all non error outputs will end (eg. evidence):\t"
read file_name

main(){
    find "$path" -type f -iname "*.${file_type}" -exec ls {} >> "${file_name}.lst" \; 2>/dev/null #add -alh if is useful to you
}

main
