#!/bin/sh
if [ $# -eq 0 ] || [ $# -gt 2 ]; then
  printf 'Usage: respath path [working-directory]\n' >&2
  exit 1
fi
path=$1
if [ $# -gt 1 ]; then
  cd "$2"
fi
cwd=`pwd -P` #Use -P option to account for directories that are actually symlinks
echo $cwd

#Handle non-relative paths, which don't need resolution
if echo "$path" | grep '^/' > /dev/null ; then
  printf '%s\n' "$path"
  exit 0
fi

#Resolve for each occurrence of ".." at the beginning of the given path.
#For performance, don't worry about ".." in the middle of the path.
while true
do
  case "$path" in
    ..*)
      if [ "$cwd" = '/' ]; then
        printf 'Invalid relative path\n' >&2
        exit 1
      fi
      if [ "$path" = '..' ]; then
        path=
      else
        path=`echo "$path" | sed 's;^\.\./;;'`
      fi
      cwd=`dirname $cwd`
      ;;
    *)
      break
      ;;
  esac
done

cwd=`echo "$cwd" | sed 's;/$;;'`
if [ -z "$path" ]; then
  if [ -z "$cwd" ]; then
    cwd='/'
  fi
  printf '%s\n' "$cwd"
else
  printf '%s/%s\n' "$cwd" "$path"
fi
