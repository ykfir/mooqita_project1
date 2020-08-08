#!/bin/bash

MiB_to_byte=2000                        # The REAL value suppose to be 1048576. Substitute after '=' if you wish

check_random_strings_file_exist() {     # Because the tee command append file in the create_random_strings_to_file function
	if [ -s ./random_strings_file ] # -s - file exist not empty (i.e. size greater than zero) create singal string and move to next func
	then
		echo -e "\nFile exist and not empty. Generates new set of random strings:\n"
		pwgen -sB 15 1 | tee ./random_strings_file 
		create_random_strings_to_file
		return
	else
		echo -e "\nFile not exist. Create new file and generate random strings:\n"
		create_random_strings_to_file
		return
	fi
}

create_random_strings_to_file() {
	while true
        do 
		pwgen -sB 15 1 | tee -a ./random_strings_file
		if [ $(stat -c%s ./random_strings_file) -gt $MiB_to_byte ]
		then
			echo -e  "\nFile has $(stat -c%s ./random_strings_file) bytes BEFORE deleting last string"
			sed -i '$d' ./random_strings_file                                # Delete last line in file
			echo -e "File has $(stat -c%s ./random_strings_file) bytes AFTER deleting last string"
			return
		fi 

	done
}

sort_random_strings_file() {
	sort -f ./random_strings_file -o ./random_strings_file  # Sorting with no importance to case. Output to the same file
	echo -e "\nSorted file:\n"
	cat ./random_strings_file
	return
}

remove_lines_start_aA() {
	echo -e "\nNumber of random strings BEFORE deleting the A's is: $(wc -l ./random_strings_file | cut -d" " -f1)"
	echo -e "The number of lines that start with 'A' or 'a' is: $(cat ./random_strings_file | grep '^[a | A]' | wc -l | cut -d" " -f1)"
	sed '/^[a | A]/d' ./random_strings_file > ./noA_random_strings_file # Deletes all strings start with A's and input to different file
	echo -e "Number of random strings AFTER deleting the A's is: $(wc -l ./noA_random_strings_file | cut -d" " -f1)\n"
	echo -e "File with NO strings that start with 'A' or 'a':\n"
	cat  ./noA_random_strings_file
	return
}

check_random_strings_file_exist
sort_random_strings_file
remove_lines_start_aA
