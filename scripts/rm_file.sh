#!/usr/bin/ksh
############################################################
# Help                                                     #
############################################################

Help()
{
   # Display Help
   echo "Will remove files depending on input. below are options for what you would like to do"
   echo
   echo "Syntax: scriptTemplate [-g|h|v|V]"
   echo "options:"
   echo "h     Print this Help."
   echo "f     sets the filename"
   echo "d     sets directory"
   echo "o     will add one of the rm options to the remove, "
   echo "      below are what each input for -o is and what they will do "
   echo
   echo "i     will ask before deleting each file."
   echo "r     will recursively delete a directory and all its contents"
   echo "f     will forcibly delete files without asking"
}

############################################################
############################################################
# Main program                                             #
############################################################
############################################################


############################################################
# Process the input options. Add options as needed.        #
############################################################
# Get the options
while getopts ":h:d:f:o:" option; do
   case $option in
      h) # display Help
         Help
         exit;;
	  d) # directory
	     rdirectory=${OPTARG};;
      f) # recursively remove plus all contents
	     rfilename=$OPTARG;;
	  o) # new directory for moving to
	     roptions=-${OPTARG};;
     \?) # Invalid option
         echo "Error: Invalid option"
         exit;;
   esac
done
echo "The arguments passed in are : $@"
echo "The number of arguments passed in are : $#"
echo "file : $rfilename"
echo "directory : $rdirectory"
echo "option : $roptions"
echo "call : $roptions $rdirectory $rfilename"


if [[ -z $1 ]];
then 
    echo "No parameter passed."
exit
fi

if [[ -z $roptions ]]; 
then
    echo "removing $rfilename $rdirectory with $roptions "
    cd $rdirectory; rm $roptions $rfilename;
    exit
else
    echo "removing $rfilename $rdirectory"
    cd $rdirectory; rm -f $rfilename;
    exit
fi

exit

