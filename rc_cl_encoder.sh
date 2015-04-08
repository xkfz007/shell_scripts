#!/bin/bash
. /cygdrive/d/workspace/as265_shell_scripts/sequence_list.seg
. /cygdrive/d/workspace/as265_shell_scripts/functions.lbr
#load default parameter values
. /cygdrive/d/workspace/as265_shell_scripts/set_encoder_default_params.seg

encoder_id="as265"

#parse command line
. /cygdrive/d/workspace/as265_shell_scripts/parse_cl.seg

for i in $seq_list
do
    seq_name=$i
    #get command line
    . /cygdrive/d/workspace/as265_shell_scripts/set_seq_related_params.seg

    cmd="${encoder_executors[$encoder_id]}"
#    cl_as265="/cygdrive/e/workspace/as265_shell_scripts/create_cl_as265.seg"
    . ${cl_list[$encoder_id]}

    cmd="$cmd >$cons 2>&1"

    echo $cmd

done
