#!/bin/bash
. /cygdrive/e/workspace/as265_shell_scripts/sequence_list.seg
. /cygdrive/e/workspace/as265_shell_scripts/functions.lbr

. /cygdrive/e/workspace/as265_shell_scripts/set_encoder_default_params.seg

#seq_list="$seq_list $classA"
#seq_list="$seq_list $classB"
seq_list="$seq_list $classC"
seq_list="$seq_list $classD"
seq_list="$seq_list $classE"
seq_list="$seq_list $classF"
#seq_list="$seq_list $othersB"
seq_list="$seq_list $othersC"
seq_list="$seq_list $othersD"
seq_list="$seq_list $othersE"
seq_list="$seq_list $othersF"
seq_list="$seq_list $othersReso"
encoder_id="x265"

. /cygdrive/e/workspace/as265_shell_scripts/parse_cl.seg

for i in $seq_list
do
    seq_name=$i
    . /cygdrive/e/workspace/as265_shell_scripts/set_seq_related_params.seg

    cmd="${encoder_executors[$encoder_id]}"
    . /cygdrive/e/workspace/as265_shell_scripts/create_cl_x265.seg

    cmd="$cmd >$cons"

    echo $cmd
done
