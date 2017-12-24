#!/bin/sh

set -x
set -e

productVersion=`sw_vers -productVersion`

mkdir "$productVersion" || true
pushd "$productVersion" 1>/dev/null 2>/dev/null

nm -jgU -arch x86_64 /usr/lib/system/libsystem_c.dylib > system_c_symbols_x86_64
nm -jgU -arch i386 /usr/lib/system/libsystem_c.dylib > system_c_symbols_i386
nm -jgU -arch x86_64 /usr/lib/system/libsystem_kernel.dylib > system_kernel_symbols_x86_64
nm -jgU -arch i386 /usr/lib/system/libsystem_kernel.dylib > system_kernel_symbols_i386

popd 1>/dev/null 2>/dev/null

git init
git add "$productVersion"
git commit -m "bump"
git checkout -b "$productVersion"
git remote add origin git@github.com:veprbl/libsystem_symbol_list.git
git push origin "$productVersion"
