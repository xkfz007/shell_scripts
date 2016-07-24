#!/bin/bash

old=`pwd`
for m3u8_file in `find . -name *index.m3u8`; do
	cd `dirname $m3u8_file`
        echo $PWD	
	find . -name "*.idx" -exec cat {} \; \
	| awk '($NF > 13 || $NF < 8) {sum+=1} \
		END{ percent=sum/NR; {print sum, NR, percent}; if (percent > 0.02) {print "!!!FAIL!!!"}}'
	cd $old
done
