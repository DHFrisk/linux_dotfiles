#!/bin/bash

# useful variables (dicts and lists)
declare -A headers_dict
declare -A files_dict
temp_files_path=()

# manually filling main dict with headers of each files type
headers_dict["ani"]="52494646"
headers_dict["au"]="2e736e64"
headers_dict["bmp",0]="424df8a9"
headers_dict["bmp",1]="424d6225" 
headers_dict["bmp",2]="424d7603"
headers_dict["cab"]="4d534346"
headers_dict["dll"]="4d5a9000"
headers_dict["xlsx",0]="d0cf11e0"
headers_dict["exe",0]="4d5a5000" 
headers_dict["exe",1]="4d5a9000"
headers_dict["flv"]="464c5601"
headers_dict["gif"]="474946383961" 
headers_dict["gif"]="474946383761"
headers_dict["gz"]="1f8b0808"
headers_dict["ico"]="00000100"
headers_dict["jpeg",0]="ffd8ffe1" 
headers_dict["jpeg",1]="ffd8ffe0" 
headers_dict["jpeg",2]="ffd8fffe"
headers_dict["elf"]="7f454c46"
headers_dict["png"]="89504e47"
headers_dict["msi"]="d0cf11e0"
headers_dict["mp3",0]="4944332e" 
headers_dict["mp3",1]="49443303"
headers_dict["oft"]="4f465432"
headers_dict["ppt"]="d0cf11e0"
headers_dict["pdf"]="25504446"
headers_dict["rar"]="52617221"
headers_dict["sfw",0]="43575306" 
headers_dict["sfw",1]="43575308"
headers_dict["tar"]="1f8b0800"
headers_dict["tgz"]="1f9d9070"
headers_dict["docx"]="d0cf11e0"
headers_dict["wmv"]="3026b275"
headers_dict["zip"]="504b0304"



# getting list of txt (supposed to be outputs of find-script.sh)
# and fill list with file names
for i in $(ls . | grep lst)
do
    temp_files_path+=($i)
done

# reading all paths from find-script.sh stored in temp_files_path
for i in ${temp_files_path[@]};
do
    current_file_name="$i-hexdumps.txt"

    # writting hexdump with no spaces or line breaks from each file found
    while read line 
    do
        echo "-----------------HEXDUMP OF FILE-----------------" >> $current_file_name
        echo "##file ---> $line " >> $current_file_name
        xxd -ps -c 0 $line >> $current_file_name 2>1 
        echo -e "-----------------END OF HEXDUMP-----------------\n" >> $current_file_name
    done < $i
done

# cleaning array used for file names storing
temp_files_path=()

# filling array with txt files where hexdumps
# are written
for i in $(ls . | grep txt)
do
    temp_files_path+=($i)
done

# looping array for file names to analyze hexdumps
for i in ${temp_files_path[@]};
do
    # reading and verifying if the line is a hexdump
    while read line
    do
        line_length=${#line}
        line_header=""
        if [[ "${line:0:2}" == "##" ]];
        then
            echo -e "\n-------------------DUMP FINDINGS------------------------" >> final-report.txt
            echo -e "$line" >> final-report.txt
        elif [[ "${line:0:1}" != "-" ]] && [[ "${line:0:1}" != " " ]];
        then
            #echo -e "\n-------------------DUMP REPORT OF FILE $line------------------------" >> final-report.txt
            for j in ${!headers_dict[@]};
            do
                header_dict_length=${#headers_dict[$j]}
                # compare hexdump header with dict header
                if [[ "${line:0:header_dict_length}" == ${headers_dict[$j]} ]];
                then
                    echo -e "The hexdump header coincide with $j <${headers_dict[$j]}> pattern!" >> final-report.txt
                    line_header=${headers_dict[$j]}
                    j=$j+1
                fi

                if [[ *"${headers_dict[$j]}"* == "$line" ]]; 
                then
                    echo -e "There has been found another hex header inside the same hexdump: $j <${headers_dict[$j]}>" >> final-report.txt
                fi
                # just realized that i was making trouble of something was already solved
                # anyway i'll let this stay here just in case

                #for (( k=${#line_header}; k<=line_length; k=k+${#headers_dict[$j]} ))
                #do
                #    if [[ "${line:$k:${#headers_dict[$j]}}" == "${headers_dict[$j]}" ]];
                #    then
                #        echo -e "There has been found another hex header inside the same hexdump: $j <${headers_dict[$j]}> in position $k"
                #    fi
                #done
            done
        fi
        #echo "-------------------------------------------------------------" >> final-report.txt
    done < $i
        
done




#for j in "${!headers_dict[@]}"
        #do
        #    header_dict_length=${#headers_dict[$j]}
        #    current_dump_header=${jeje:0:$header_dict_length}
        #    echo $current_dump_header $header_dict_length
        #    #if [current_dump_header == ${headers_dict[$j]}];
        #    #then
        #    #    echo "The file header is ${headers_dict[$j]}" 
        #    #fi
        #done


## tests
#for i in ${temp_files_path[@]}; 
#do
#    echo $i
#done
#
#for i in "${!headers_dict[@]}"
#do
#    echo "$i -> ${headers_dict[$i]}"
#done
