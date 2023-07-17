#  $* is a single string, whereas $@ is an actual array

# command:
# > ./test.sh one two "three four"

#script:
#!/bin/bash

echo "Using \"\$*\":"
for a in "$*"; do
    echo $a;
done

echo -e "\nUsing \$*:"
for a in $*; do
    echo $a;
done

echo -e "\nUsing \"\$@\":"
for a in "$@"; do
    echo $a;
done

echo -e "\nUsing \$@:"
for a in $@; do
    echo $a;
done      



# output:

# Case 1 - the parameters are regarded as one long quoted string:
# Using "$*":
# one two three four

# Case 2 (unquoted) - the string is broken into words by the for loop:
# Using $*:
# one
# two
# three
# four

# Case 3 - it treats each element of $@ as a quoted string:
# Using "$@":
# one
# two
# three four

# Case 4 - it treats each element as an unquoted string, so the last one is again split by what amounts to for three four:
# Using $@:
# one
# two
# three
# four


























