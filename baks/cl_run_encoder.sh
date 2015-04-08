#!/bin/bash
#../bin/Win32/Release/ashevc.exe d:\\workspace\\arcsoft_codes\\HEVC_Codec\\cfg\\ ashevc_test.cfg |tee cons.txt

. /cygdrive/e/workspace/as265_shell_scripts/functions.lbr
. /cygdrive/e/workspace/as265_shell_scripts/set_encoder_default_params.seg

seq_name="BlowingBubbles_416x240_50"
output_path="e:/encoder_test_output/as265_output/"
encoder_id="as265"

. /cygdrive/e/workspace/as265_shell_scripts/parse_cl.seg

#cmd="/cygdrive/d/workspace/arcsoft_codes/HEVC_Codec/bin/Win32/Release/ashevc.exe"

. /cygdrive/e/workspace/as265_shell_scripts/set_seq_related_params.seg

cmd="${encoder_paths[$encoder_id]}${encoder_executors[$encoder_id]}"
. /cygdrive/e/workspace/as265_shell_scripts/create_cl_as265.seg
cmd="$cmd 2>&1 |tee $cons"
echo $cmd
eval $cmd
