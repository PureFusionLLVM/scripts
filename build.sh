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

export TOOLCHAIN_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";

# Check if the desired version is valid
# if [[ "$1" =~ ^[0-9]+(\.[0-9]+)?$ ]] ; then
    export FUSIONCLANG_BRANCH=$1
	export FUSIONCLANG_VERSION=$2
# fi;

if [ "$1" == "5" ]; then
    export FUSIONCLANG_BRANCH=release_50
	export FUSIONCLANG_VERSION=5
fi

if [ "$1" == "6" ]; then
    export FUSIONCLANG_BRANCH=release_60
	export FUSIONCLANG_VERSION=6
fi

if [ "$1" == "7" ]; then
    export FUSIONCLANG_BRANCH=release_70
	export FUSIONCLANG_VERSION=7
fi

if [ "$1" == "master" ]; then
    export FUSIONCLANG_BRANCH=master
	export FUSIONCLANG_VERSION=7
fi

if [ "$1" == "" ]; then
    export FUSIONCLANG_BRANCH=release_06
	export FUSIONCLANG_VERSION=6
	echo "NOTE: No ARG given so using release_06 branch:"
fi

echo "Current Settings: Branch: $FUSIONCLANG_BRANCH Version: $FUSIONCLANG_VERSION"
./scripts/fusionclang
