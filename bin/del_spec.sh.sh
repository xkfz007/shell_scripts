#/bin/bash
if [ $# -ne 2 ]
then
    echo "usage del_spec dir SPEC" 1>&2
    exit 1
fi
delete()
{
    cd "$1"
    pwd
    cmd='rm -rv $2'
    eval "$cmd"
    for i in *
    do
        if [ -d "$i" ] 
        then
            delete "$i" "$2"
        fi
    done
    cd ..

}
delete "$1" "$2"
