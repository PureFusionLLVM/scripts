#!/bin/bash
# Copyright (C) 2018 PureFusionOS == PureFusionTC == PureFusionLLVM
#
# Licensed under the Apache License, Version 2.0 (the "License");
#   You may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

export PFLLVM_USE_LLD="OFF";
export PFLLVM_USE_THINLTO="OFF";

# Enable ccache if requested
if ! [ -z "$PFLLVM_USE_CCACHE" ];
then
  export PFLLVM_CCACHE=ON;
else
  export PFLLVM_CCACHE=OFF;
fi;

export TOOLCHAIN_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";

###########################################################################
###########################################################################
#####                                                                 #####
#####      P U R E F U S I O N L L V M  B U I L D  S Y S T E M S      #####
#####                          (C) 2018                               #####
###########################################################################
###########################################################################

show_help() {
  echo "Usage: `basename $0` [5/6/7/master] [opt] [lld/thinlto] [cache]"
  echo ""
  echo "Example: `basename $0` 7 opt thinlto"
  echo "Example2: `basename $0` 7 lld"
  echo ""
  echo "Default Master is always the latest LLVM/Clang available"
  echo ""
  echo ""
  echo "Commands:"
  echo "-h  Show this menu."
  echo ""
  echo "--help  Also shows this menu."
  echo ""
  echo "opt  Builds using -march=native -mtune=native."
  echo "     Building with this makes it for your system only."
  echo ""
  echo "lld  Builds using lld as the linker. This enables clang as host toolchain."
  echo ""
  echo "thinlto  Enables thinlto during the build. This enables clang as host toolchain."
  echo "         It also enables lld as the linker and increases build time."
  echo ""
  echo "To enable ccache export PFLLVM_USE_CCACHE=1 before running the script."
  echo ""
  exit 0
}

# Check if the desired version is valid
# if [[ "$1" =~ ^[0-9]+(\.[0-9]+)?$ ]] ; then
    export PFLLVM_BRANCH=$1
	export PFLLVM_VERSION=$2
# fi;

if [ "$1" == "5" ]; then
    export PFLLVM_BRANCH=release_50;
	export PFLLVM_VERSION=5;
	export PFLLVM_LIB_VERSION="5.0.1";

elif [ "$1" == "6" ]; then
    export PFLLVM_BRANCH=release_60;
	export PFLLVM_VERSION=6;
	export PFLLVM_LIB_VERSION="6.0.1";

elif [ "$1" == "7" ]; then
    export PFLLVM_BRANCH=master;
	export PFLLVM_VERSION=7;
	export PFLLVM_LIB_VERSION="7.0.0";

elif [ "$1" == "master" ]; then
    export PFLLVM_BRANCH=master;
	export PFLLVM_VERSION=7;
	export PFLLVM_LIB_VERSION="7.0.0";

elif [ "$1" == "-h" ]; then
  show_help
elif [ "$1" == "--help" ]; then
  show_help
else
  show_help
fi

# Setup build options
if [ "$2" == "opt" ]; then
  export OPT="-march=native -mtune=native";
elif [ "$2" == "lld" ]; then
  export CC="clang";
  export CXX="clang++";
  export PFLLVM_USE_LLD="ON";
elif [ "$2" == "thinlto" ]; then
  export CC="clang";
  export CXX="clang++";
  export PFLLVM_USE_LLD="ON";
  export PFLLVM_USE_THINLTO="Thin";
fi;

if [ "$3" == "lld" ]; then
  export CC="clang";
  export CXX="clang++";
  export PFLLVM_USE_LLD="ON";
elif [ "$3" == "thinlto" ]; then
  export CC="clang";
  export CXX="clang++";
  export PFLLVM_USE_LLD="ON";
  export PFLLVM_USE_THINLTO="Thin";
fi;

if [ "$4" == "cache" ]; then
  export PFLLVM_CCACH="ON";
  export CCACHE_DIR="~/.ccache"
  export CCACHE_MAXSIZE="1GB"
fi;

echo "Current Settings: Branch: $PFLLVM_BRANCH Version: $PFLLVM_VERSION PFLLVM_USE_LLD: $PFLLVM_USE_LLD PFLLVM_USE_THINLTO: $PFLLVM_USE_THINLTO OPT: $OPT PFLLVM_CCACH: $PFLLVM_CCACH"
./scripts/pfllvm
