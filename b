#!/bin/bash

# todo
# - detect make a build target

help-prompt() {
    echo "usage: b <buildopts>"
    echo 
    echo "A simple build runner, add build.sh or source code in certain languages, then run b to build"  
    echo "   -h, --help         for this help message"
    echo "   -g, --generate     add a build.sh to your project"
}

dohelp=false; generate=false
while true; do
    case "$1" in
        -h|--help) dohelp=true; shift;;
        -g|--generate) generate=true; shift;;
    esac 
done

$dohelp && help-prompt && exit 0

if $generate; then
    echo creating build.sh
    
    cat << EOF > build.sh 
#!/bin/env bash
set -xe

echo build.sh: reminder no logic, please edit.
exit 1 
EOF

    chmod +x build.sh
    exit 0
fi

if ls build.sh &> /dev/null; then # || [ -f build*.sh]; then
    if [ ! -x build.sh ]; then
        echo Warning: build.sh is not executable
        exit 1
    fi

    ./build.sh $@
    exit 0

if ls nob.* &> /dev/null; then
    cc nob.c -o nob
    ./nob
fi

elif ls *.odin &> /dev/null; then
    echo running odin run:
    odin run .
    exit 0

elif ls *.go &> /dev/null; then
    echo running go run:
    go run .
    exit 0
fi

echo Warning: no build options!
echo 
help-prompt

exit 1

