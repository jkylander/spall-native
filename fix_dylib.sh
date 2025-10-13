set -x

DYLIB_NAME=$1
BIN_PATH=$2

DYLIB_PATH=$(otool -L $BIN_PATH | grep -m 1 $DYLIB_NAME | awk -F '.dylib' '{print $1".dylib"}' | awk '{$1=$1};1')
install_name_tool -change $DYLIB_PATH @executable_path/../Frameworks/$DYLIB_NAME $BIN_PATH
