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


if [[ $1 == "-h" ]] || [[ $1 == "--help" ]]; then
    help-prompt

    exit 0
fi

if [[ $1 == "-g" ]] || [[ $1 == "--generate" ]]; then
    echo creating build.sh
    echo -n "#!/bin/env bash
set -xe

echo build.sh: reminder no logic, please edit.
exit 1" > build.sh 

    chmod +x build.sh
    exit 0
fi

if ls build.sh &> /dev/null ; then # || [ -f build*.sh]; then
    if [ ! -x build.sh ]; then
        echo Warning: build.sh is not executable
        exit 1
    fi

    ./build.sh $@
    exit 0

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

