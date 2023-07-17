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
   echo "n 	   Set Name value."
   echo "c 	   Set City value."
   echo "s 	   Set Street value."
   echo "S 	   Set State value."
   echo "z 	   Set Zip value."
   echo "a 	   Set first digit value."
   echo "b 	   Set second digit value."
   echo
}

############################################################
############################################################
# Main program                                             #
############################################################
############################################################

# Set variables
Name=$1
street=$2
city=$3
state=$4
zip=$5
numa=$6
numb=$7
############################################################
# Process the input options. Add options as needed.        #
############################################################
# Get the options
while getopts ":h:n:s:c:S:z:a:b:" option; do
   case $option in
      h) # display Help
         Help
         exit;;
      n) # Enter a name
         Name=$OPTARG;;
      s) # Enter a street
	     street=$OPTARG;;
	  c) # Enter a city
	     city=$OPTARG;;
	  S) # Enter a state
	     state=$OPTARG;;
	  z) # Enter a street
	     zip=$OPTARG;;
	  a) # Enter first digit
	     numa=${OPTARG};;
	  b) # Enter second digit
	     numb=${OPTARG};;
     \?) # Invalid option
         echo "Error: Invalid option"
         exit;;
   esac
done
if [[ -z $1 ]];
then 
    echo "No parameter passed."
else
echo "for loop going through each thing entered"
for i in $@
do 
        echo -e "$i\n"
done
echo "while loop going through each parameter"
i=$(($#-1))
while [ $i -ge 0 ];
do
    echo ${BASH_ARGV[$i]}
    i=$((i-1))
done
echo "Main program function:"
echo "Name: $Name"
echo "Street: $street"
echo "City: $city"
echo "State/Province/Territory: $state"
echo "Zip/Postal code: $zip"
echo "The arguments passed in are : $@"
echo "The number of arguments passed in are : $#"
echo "digit 1: $numa"
echo "digit 2: $numb"
a=$numa
b=$numb
p=$(($a*$b))
echo "The product of $a and $b = $p"
fi