#!/bin/bash
set -e 
set -x
filter(){
    pat=$1
    shift
    for v; do
        cmd="case $v in $pat) echo $v ;; esac"
        echo $cmd
        eval $cmd
    done
}
check_cc(){
    log check_cc "$@"
    cat > $TMPC
    log_file $TMPC
    check_cmd $cc $CPPFLAGS $CFLAGS "$@" $CC_C $(cc_o $TMPO) $TMPC
}

check_cxx(){
    log check_cxx "$@"
    cat > $TMPCPP
    log_file $TMPCPP
    check_cmd $cxx $CPPFLAGS $CFLAGS $CXXFLAGS "$@" $CXX_C -o $TMPO $TMPCPP
}

check_objcc(){
    log check_objcc "$@"
    cat > $TMPM
    log_file $TMPM
    check_cmd $objcc -Werror=missing-prototypes $CPPFLAGS $CFLAGS $OBJCFLAGS "$@" $OBJCC_C $(cc_o $TMPO) $TMPM
}

check_cpp(){
    log check_cpp "$@"
    cat > $TMPC
    log_file $TMPC
    check_cmd $cc $CPPFLAGS $CFLAGS "$@" $(cc_e $TMPO) $TMPC
}

as_o(){
    eval printf '%s\\n' $AS_O
}

check_as(){
    log check_as "$@"
    cat > $TMPS
    log_file $TMPS
    check_cmd $as $CPPFLAGS $ASFLAGS "$@" $AS_C $(as_o $TMPO) $TMPS
}

check_inline_asm(){
    log check_inline_asm "$@"
    name="$1"
    code="$2"
    shift 2
    disable $name
    check_cc "$@" <<EOF && enable $name
void foo(void){ __asm__ volatile($code); }
EOF
}

check_inline_asm_flags(){
    log check_inline_asm_flags "$@"
    name="$1"
    code="$2"
    flags=''
    shift 2
    while [ "$1" != "" ]; do
      append flags $1
      shift
    done;
    disable $name
    cat > $TMPC <<EOF
void foo(void){ __asm__ volatile($code); }
EOF
    log_file $TMPC
    check_cmd $cc $CPPFLAGS $CFLAGS $flags "$@" $CC_C $(cc_o $TMPO) $TMPC &&
    enable $name && add_cflags $flags && add_asflags $flags && add_ldflags $flags
}

check_insn(){
    log check_insn "$@"
    check_inline_asm ${1}_inline "\"$2\""
    echo "$2" | check_as && enable ${1}_external || disable ${1}_external
}

check_yasm(){
    log check_yasm "$@"
    echo "$1" > $TMPS
    log_file $TMPS
    shift 1
    check_cmd $yasmexe $YASMFLAGS -Werror "$@" -o $TMPO $TMPS
}

print_include(){
    hdr=$1
    test "${hdr%.h}" = "${hdr}" &&
        echo "#include $hdr"    ||
        echo "#include <$hdr>"
}

check_code(){
    log check_code "$@"
    check=$1
    headers=$2
    code=$3
    shift 3
    {
        for hdr in $headers; do
            print_include $hdr
        done
        echo "int main(void) { $code; return 0; }"
    } | check_$check "$@"
}
tmpfile(){
    tmp=$(mktemp -u "${TMPDIR}/ffconf.XXXXXXXX")$2 &&
        (set -C; exec > $tmp) 2>/dev/null ||
        die "Unable to create temporary file in $TMPDIR."
    append TMPFILES $tmp
    eval $1=$tmp
}
tmpfile TMPC   .c
tmpfile TMPCPP .cpp
