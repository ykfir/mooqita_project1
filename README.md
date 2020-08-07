# mooqita_project1
Creating file with random strings, sorting it, eliminate all strings starting with 'A' or 'a' and input the remaining strings into a new file.

1) Explain the process how you create the lines in your file ?

The function create_random_strings_to_file() I used the tee command with the appending option (tee –a). In order to avoid the tee command to try to append to already existing file I created (which will terminate the function as a result of file bigger that MiB_to_byte immediately in case that this file already exists) another function (check_random_strings_file_exist()) which checks for the existence of such file. If file exists than it delete the previous files’ strings and starts to create new set of strings; If file does not exist than the script creates new file and fill it with random strings. The random strings created by the command pwgen which is a password generator with many options.

2) What is a good way to control the size of a file? Discuss what options you know and why you picked one of them. Come up with two ways in Linux to find the size of a file. 

a. Good way to control the size of a file is by checing and compairng to fix value using the 'if' statement. Once file passes it designated size (i.e MiB_to_byte=1048576 bytes) than I delete the last strings that caused the file to exceed the size and then stop input more terms (i.e. exit the create_random_strings to_file() function)

b. Two options to get the size of a file: using the stat command (stat –c%s foo) or extract the integer from wc –c command (wc –c foo | cut –f1 –d’ ‘).

c. I picked up ‘stat –c%s foo’ for no particular reason. Either one is working very well to this purpose.

3) Which sort one did you use? Why? What is the most common command in Linux to sort a file and what happens when you use the default option, i.e. using no specific sorting option?

I used the 'sort' command while treating capital letter equal to lower case ones in the sorting process (-f option). The reason I decided to sort that way is after asking couple of my work colleagues about their sorting preferences. ‘sort’ is the most common Linux command to sort data and using it without any additional options it would sort the same way as sort-f provide the variable LC_ALL=en_US and not equal to the value ‘C’ (i.e. LC_ALL=C). The 'sort –f' (or 'sort') will sort digits (0-9) first and than according to the English alphabet order.

4) Remove all lines that start with an “a”, no matter if it is in uppercase or lowercase. Safe the result into a new file. Use regular expressions to do this. How many lines were removed?

Since the generated strings are random it is impossible to predict how many strings start with ‘A’ or ‘a’ will be removed from the sorted file.
