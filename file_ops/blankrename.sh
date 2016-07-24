#! /bin/bash
# blank-rename.sh
#
# Substitutes underscores for blanks in all the filenames in a directory.

ONE=1 # For getting singular/plural right (see below).
number=0 # Keeps track of how many files actually renamed.
FOUND=0 # Successful return value.

for filename in appCD arglst arglst.sh arrayops arrayops.sh arraystrops arraystrops.sh bash bash.sh betweendays betweendays.sh blankrename blankrename.sh bubble.sh calDirSize cannon.sh changname cstringfuncs.sh evalTest2 filegroup ftpget.sh getopt.sh getpasswd.sh jpgrename letterCount.sh nautilus-dropbox-script.sh objOrient.sh primes.sh qseries.sh rdn.sh redirFor2.sh redirFor.sh redirIf.sh redirUntil.sh redirWhile2.sh redirWhile.sh rename.sh sieve.sh soundex.sh stack.sh toroman.sh untilFor2.sh usb.sh wf2.sh #Traverse all files in directory.
do
echo "$filename" | grep -q " " # Check whether filename
if [ $? -eq $FOUND ] #+ contains space(s).
then
fname=$filename # Strip off path.
n=`echo $fname | sed -e "s/ /_/g"` # Substitute underscore for blank.
mv "$fname" "$n" # Do the actual renaming.
let "number += 1"
fi
done

if [ "$number" -eq "$ONE" ] # For correct grammar.
then
echo "$number file renamed."
else
echo "$number files renamed."
fi

exit 0
