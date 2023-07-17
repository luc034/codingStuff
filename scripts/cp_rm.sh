#!/bin/bash
############################################################
# Help                                                     #
############################################################
Help()
{
   # Display Help
   echo "Add description of the script functions here."
   echo
   echo "Syntax: scriptTemplate [-g|h|v|V]"
   echo "options:"
   echo "g     Print the GPL license notification."
   echo "h     Print this Help."
   echo "v     Verbose mode."
   echo "V     Print software version and exit."
   echo
}

############################################################
############################################################
# Main program                                             #
############################################################
############################################################

# Set variables
#action=$1
#old_directory=$2
#new_directory=$3
#echo "for loop going through each thing entered"
#for i in $@
#do 
#        echo -e "$i\n"
#done
#echo "while loop going through each parameter"
#i=$(($#-1))
#while [ $i -ge 0 ];
#do
#    echo ${BASH_ARGV[$i]}
#    i=$((i-1))
#done


############################################################
# Process the input options. Add options as needed.        #
############################################################
# Get the options
while getopts ":h:n:o:c:p:r:s:" option; do
   case $option in
      h) # display Help
         Help
         exit;;
	  c) # Enter a city
	     action="cp "$OPTARG;;
	  p) # Enter a city
	     action="cp -p";;
	  r) # Enter a city
	     action="rm "$OPTARG;;
	  s) # Enter a city
	     action="rm -r";;
	  n) # Enter second digit
	     old_directory=${OPTARG};;
	  o) # Enter second digit
	     new_directory=${OPTARG};;
	  a) # Enter first digit
	     numa=${OPTARG};;
	  b) # Enter second digit
	     numb=$OPTARG;;
     \?) # Invalid option
         echo "Error: Invalid option"
         exit;;
   esac
done
echo "The arguments passed in are : $@"
echo "The number of arguments passed in are : $#"
echo "old_directory : $old_directory"
echo "new_directory : $new_directory"
echo "action : $action"
echo "call : $action $old_directory $new_directory"
if [[ -z $1 ]];
then 
    echo "No parameter passed."
#elif [[ -z $new_directory]]
#$action $old_directory
else
$action $old_directory $new_directory
exit

fi