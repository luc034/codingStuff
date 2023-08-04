#!/usr/bin/ksh
############################################################
# Help                                                     #
############################################################

Help()
{
   # Display Help
   echo "Will copy or remove files depending on input. below are options for what you would like to do"
   echo
   echo "Syntax: scriptTemplate [-g|h|v|V]"
   echo "options:"
   echo "h     Print this Help."
   echo "c     Copy plus option."
   echo "p     copys preserving timestamp and ownership"
   echo "r     remove plus option"
   echo "s     recursively remove plus all contents"
   echo "n     first directory"
   echo "o     new directory for moving to"
   echo
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
while getopts ":h:n:o:c:p:r:s:" option; do
   case $option in
      h) # display Help
         Help
         exit;;
	  c) # Copy plus option
	     action="cp "$OPTARG;;
	  p) # copys preserving timestamp and ownership
	     action="cp -p";;
	  r) # remove plus option
	     action="rm "$OPTARG;;
	  s) # recursively remove plus all contents
	     action="rm -r";;
	  n) # first directory
	     old_directory=${OPTARG};;
	  o) # new directory for moving to
	     new_directory=${OPTARG};;
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
fi

if [[ $action == *"rm"* ]]; 
then
    echo "removing $new_directory $old_directory"
   cd $old_directory; $action $new_directory;
else
    echo "copying $old_directory $new_directory"
$action $old_directory $new_directory
fi
exit
