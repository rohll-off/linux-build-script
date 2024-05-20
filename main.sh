#!/bin/bash

HELP1="CPU Optimizations can improve the performance of a program by allowing the compiler to produce binaries that make use of newer processor instructions (e.g: SSE 4.2, AVX) and/or by optimzizing for your processors microarchitecture. These will not always make a measureable difference, it may depend on your hardware"
HELP2="If you are compiling for your own machine, you can pick ""Native"" or run the psABI checking script to see the highest level for your machine. Run script? (yes/no)"
OPT_LEVEL=""
KBUILD_KCPPFLAGS=""
ABI_CHECK=""
KKBUILD_KCFLAGS=""
CLEAN_BUILD=""
OPT=""
PATCHES=""
MAINLINE=""
KERNEL_VERSION=""
DEPS=""

echo "Welcome to the Linux build script"
echo "Please answer the following to configure the builder"

echo "Would you ike the script to purge the build directory after it is done?"
read CLEAN_BUILD
echo "Would you like to Build the latest stable kernel? (yes/no)"
read MAINLINE

if [ "$MAINLINE" == "no" ]; then
    echo "Please enter the link to the desired version tar file from cdn.kernel.org"
    read KERNEL_VERSION
fi

echo "Would you like to apply Compiler optimizations (yes/no)?"
read opt

if [ "$opt" == "yes" ]; then
   
 echo "Would you like to enable -O3? (yes/no)"
  read O3

    	if [ "$O3" == "yes" ]; then
        KBUILD_CFLAGS+=" -O3"
        KBUILD_KCPPFLAGS+=" -O3"
   	 fi

 echo "Would you like to enable Link-time optimization (LTO)? (yes/no)"
  read LTO

	if ["$LTO" == "yes"]; then
		KBUILD_KCFLAGS+=" -flto"
		KBUILD_KCPPFLAGS+=" -flto"
	fi



 echo "Would you like to apply cpu-architecture specific optimizations? (yes/no/?)"
  read CPU_OPTIMIZATION
	
		case $CPU_OPTIMIZATION in
			"yes")
				echo "What level would you like to optimize for?
				1: x86-64-v1
				2: x86-64-v2
				3: x86-64-v3
				4: x86-64-v4
				5: Native
				6: Help"
				
				read OPT_LEVEL

					case OPT_LEVEL in

						"1")
							KBUILD_KCFLAGS+=" -march=generic"
							KBUILD_KCPPFLAGS+=" -march=generic"
							;;
						"2")
							KBUILD_KCFLAGS+=" -march=x86_64-v2"
							KBUILD_KCPPFLAGS+=" -march=x86_64-v2"
							;;
						"3")
							KBUILD_KCFLAGS+=" -march=x86_64-v3"
							KBUILD_KCPPFLAGS+=" -march=x86_64-v3"
							;;
						"4")
							KBUILD_KCFLAGS+=" -march=x86_64-v4"
							KBUILD_KCPPFLAGS+=" -march=x86_64-v4"
							;;
						"5")
							KBUILD_KCFLAGS+=" -march=native"
							KBUILD_KCPPFLAGS+=" -march=native"

							;;

						"6")
							echo HELP2
							echo "What level would you like to optimize for?
		                                	1: x86-64-v1
                		                	2: x86-64-v2
                                			3: x86-64-v3
                               			 	4: x86-64-v4
                                			5: Native
                                			6: Help"
							read OPT_LEVEL
							;;
