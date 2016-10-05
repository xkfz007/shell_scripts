#!/bin/bash
#get the file extension from filename
#with '.'
#like a.mp4.mkv => .mkv
function get_ext()
{
    local filename=$1
    local ext=${filename##*.}
    ext='.'${ext}
    echo "$ext"
}
function get_fname()
{
    local filename=$1
    local name=${filename%.*}
    echo $name
}

#TEST CODES
#{
#filename="a.mp4.mkv"
#ext=$(get_ext $filename)
#echo $ext
#fname=$(get_fname $filename)
#echo $fname
#}


#replace a line of file
function replace_line_by_number
{
   local f=$1
   local lineno=$2
   local content=$3
   sed -i "${lineno}s/.*/${content}/g" $f
}

#escape slash
#like: /usr/bin/=>\/usr\/bin\/
function escape_slash
{
	local str=$1
	local res=${str//\//\\\/} 
	echo "$res"
}
function escape_backslash
{
	local str=$1
	local res=${str//\\/\\\\} 
	echo "$res"
}

#get the specified line of file
function get_line_by_number
{
	local f=$1
	local line_no=$2
	local line_no2=''
	if [ $# -gt 2 ];then
	    line_no2=$3
	fi
	if [ "$line_no2" = '0' ];then
	    line_no2="$line_no"
	    line_no="1"
	elif [ "$line_no2" = '-1' ];then
	    line_no2="\$"
	elif [ "$line_no2" == '' ];then
	    line_no2=$line_no
	fi
	if [ "$line_no" = '-1' ];then
	    line_no="\$"
	fi

    local content=$(sed -n "${line_no},${line_no2}p" $f)
    echo $content
}
#TEST CODE
line=$(get_line_by_number funcs.sh 1)
echo $line
line=$(get_line_by_number funcs.sh 2 -1)
while read i
do
    echo $i
done <<<"$line"

function get_line_by_pattern
{
    #qp1=`grep "$pat" $cons|awk '{print $22}'`
	local f=$1
	local pat=$2
    local content=$(sed -n "/$pat/p" $f)
}

#get the line count of file
function get_line_count
{
   local file=$1
   local count=$(awk 'END {print NR}' $file)
   echo $count
}

#check if value is number
#use regex [[ ]]
function is_number
{
   local val=$1
   if [[ "$val" =~ ^[0-9]+$ ]]; then
        echo "yes"
    else
        echo "no"
   fi
}

# Avoid locale weirdness, besides we really just want to translate ASCII.
toupper(){
    #echo "$@" | tr abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ
    echo "$@" | tr '[a-z]' '[A-Z]'
}

tolower(){
    echo "$@" | tr ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz
}

c_escape(){
    echo "$*" | sed 's/["\\]/\\\0/g'
}

sh_quote(){
    v=$(echo "$1" | sed "s/'/'\\\\''/g")
    test "x$v" = "x${v#*[!A-Za-z0-9_/.+-]}" || v="'$v'"
    echo "$v"
}

cleanws(){
    echo "$@" | sed 's/^ *//;s/[[:space:]][[:space:]]*/ /g;s/ *$//'
}
 