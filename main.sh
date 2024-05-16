CXXFLAGS=""
CFLAGS=""
CLEAN_BUILD=""
OPT=""
PATCHES=""
MAINLINE=""
KERNEL_VERSION=""
DEPS=""

echo "Welcome to the Linux build script"
echo "Please answer the following to configure the builder"

echo "Would you like the script to purge the build directory after it is done?"
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
    LTO=""
    O3=""
    CPU_OPTIMIZATION=""
    MARCH=""
   
 echo "Would you like to enable -O3? (yes/no)"
  read O3

    	if [ "$O3" == "yes" ]; then
        CFLAGS+=" -O3"
        CXXFLAGS+=" -O3"
   	 fi

 echo "Would you like to enable Link-time optimization (LTO)? (yes/no)"
  read LTO

	if ["$LTO" == "yes"]; then
		CFLAGS+=" -flto"
		CXXFLAGS+=" -flto"
	fi



 echo "Would you like to apply cpu-architecture specific optimizations? (yes/no/?)"
  read CPU_OPTIMIZATION
	


echo "$CFLAGS"
