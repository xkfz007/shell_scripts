#!/bin/bash
# general pkg file for some libs                                                                                                                                                         
pkgconfig_generate(){                                                                                                                                                                   
    name=$1                                                                                                                                                                             
    comment=$2                                                                                                                                                                          
    version=$3                                                                                                                                                                          
    libs=$4                                                                                                                                                                             
    pkg_prefix=$5                                                                                                                                                                       
    cat <<EOF  >"${pkg_prefix}/lib/pkgconfig/${name}.pc"                                                                                                                                
prefix=${pkg_prefix}                                                                                                                                                                    
exec_prefix=\${prefix}                                                                                                                                                                  
libdir=\${exec_prefix}/lib                                                                                                                                                              
includedir=\${prefix}/include                                                                                                                                                           
                                                                                                                                                                                        
Name: $name                                                                                                                                                                             
Description: $comment                                                                                                                                                                   
Version: $version                                                                                                                                                                       
Libs: -L\${libdir} -l${name}                                                                                                                                                            
Libs.private: ${libs}                                                                                                                                                                   
Cflags: -I\${includedir}                                                                                                                                                                
EOF                                                                                                                                                                                     
                                                                                                                                                                                        
}                                                                                                                                                                                       
                                                                                                                                                                                        
regen_pkg=1                                                                                                                                                                             
if [ $regen_pkg -eq 1 ];then                                                                                                                                                            
    test -e ${PKG_DIR} || mkdir -p ${PKG_DIR}                                                                                                                                           
    if [ $sys_name = "linux" ];then                                                                                                                                                     
        pkgconfig_generate "x264"    "H.264 (MPEG4 AVC) encoder library" "0.148.x" "-lpthread -lm -ldl"      "${PKG_PREFIX}"                                                            
        pkgconfig_generate "x265"    "H.265/HEVC video encoder"          "1.9"     "-lstdc++ -lm -lrt -ldl"  "${PKG_PREFIX}"                                                            
        pkgconfig_generate "fdk-aac" "AAC Codec Library"                 "0.1.4"   "-lm"                     "${PKG_PREFIX}"                                                            
    elif [ $sys_name = "cygwin" ];then                                                                                                                                                  
        pkgconfig_generate "x264"    "H.264 (MPEG4 AVC) encoder library" "0.148.x" "-lpthread -lm -ldl"      "${PKG_PREFIX}"                                                            
        pkgconfig_generate "x265"    "H.265/HEVC video encoder"          "2.0"     "-lstdc++ -lcygwin -ladvapi32 -lshell32 -luser32 -lkernel32 -lrt -ldl"  "${PKG_PREFIX}"              
        #pkgconfig_generate "fdk-aac" "AAC Codec Library"                 "0.1.4"   ""                     "${PKG_PREFIX}"                                                              
    fi                                                                                                                                                                                  
fi   