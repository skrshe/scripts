#!/bin/bash

# todo
# - detect Makefile as a build script

main() {
    while true; do
    case "$1" in
    -h|--help) help-prompt; exit 0 ;;
    
    -g|--generate) 
        echo creating build.sh
        cat <<- "        USAGE" > build.sh 
		#!/bin/env bash
		set -xe
		
		echo build.sh: reminder no logic, please edit.
		exit 1 
        USAGE
    
        chmod +x build.sh
        exit 0
        ;;

    --) shift; break ;;

    *) break ;;
    esac 
    done
    
    if ls build.sh &> /dev/null; then # || [ -f build*.sh]; then
        if [ ! -x build.sh ]; then
            echo Warning: build.sh is not executable
            exit 1
        fi
    
        ./build.sh $@
        exit 0
    
    elif ls nob.c &> /dev/null; then
        echo running zozin\'s nob:
        cc nob.c -o nob
        ./nob
    
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
}

# defs
help-prompt() {
    cat <<- "    USAGE"
	Usage: b [options] -- <buildopts>
	       b <buildopts>

	A simple build runner, add build.sh or source code in certain languages, then run b to build
	
	Arguments:
	    <buildopts>
	        flags and arguments to pass to the current ./build script / runner
	
	Options:
	    -h, --help         
	        for this help message
	    -g, --generate     
	        add a build.sh to your project
	    --
	        dont interpret flags for b past this point.  
    USAGE
}

# main call
main "$@"
