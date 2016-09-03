#!/bin/bash
if [ $# -lt 1  ]; then
    echo "usage:vmstart.sh <vm>"
    echo "available machines:cs,cs2,cs3,us,us2,us3,xs"
    exit 1
fi
declare -A  dic
dic=(['cs']="e:/virtual_machines/CentOS-Server/CentOS-Server.vmx"  \
     ['cs2']="e:/virtual_machines/CentOS-Server2/CentOS-Server2.vmx"  \
     ['cs3']="e:/virtual_machines/CentOS-Server2/CentOS-Server3.vmx"  \
     ['us']="e:/virtual_machines/Ubuntu-Server/Ubuntu-Server.vmx"  \
     ['us2']="e:/virtual_machines/Ubuntu-Server2/Ubuntu-Server.vmx"  \
     ['us3']="e:/virtual_machines/Ubuntu-Server3/Ubuntu-Server.vmx"  \
     ['xs']="e:/virtual_machines/XUbuntu-Server/XUbuntu-Server.vmx"  \
     ['xs2']="e:/virtual_machines/XUbuntu-Server2/XUbuntu-Server.vmx"  \
    )
key=$1
vmx_path=${dic[$key]}
if [ x"$vmx_path" == x"" ];then
    vmx_path=$1
fi
#vmrun.exe start $vmx_path  nogui
cmd="vmrun.exe start $vmx_path  nogui"
echo $cmd
eval $cmd
