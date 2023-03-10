# _     _            _        _          _____
#| |__ | | __ _  ___| | _____| | ___   _|___ /
#| '_ \| |/ _` |/ __| |/ / __| |/ / | | | |_ \
#| |_) | | (_| | (__|   <\__ \   <| |_| |___) |
#|_.__/|_|\__,_|\___|_|\_\___/_|\_\\__, |____/
#                                  |___/

#Maintainer: blacksky3 <https://github.com/blacksky3>

# toolchain build order: linux-api-headers->glibc->binutils->gcc->glibc->binutils->gcc
# NOTE: valgrind requires rebuilt with each major glibc version
# NOTE: libtool requires rebuilt with each new gcc version

#!/bin/bash

source=$(pwd)

echo "${source}"

# prepare

# makepkg --verifysource to grap same version for package stage1/stage2 build

cd linux-api-headers-git && makepkg --verifysource && cd ${source}

cd glibc-git && makepkg --verifysource && cd ${source}

cd binutils-git && makepkg --verifysource && cd ${source}

cd gcc-git && makepkg --verifysource && cd ${source}

# create stage 1 build dir

if ! dir glibc-stage1; then
  cp -r glibc-git glibc-stage1
fi

if ! dir binutils-stage1; then
  cp -r binutils-git binutils-stage1
fi

if ! dir gcc-stage1; then
  cp -r gcc-git gcc-stage1
fi

# create stage 2 build dir

if ! dir glibc-stage2; then
  cp -r glibc-git glibc-stage2
fi

if ! dir binutils-stage2; then
  cp -r binutils-git binutils-stage2
fi

if ! dir gcc-stage2; then
  cp -r gcc-git gcc-stage2
fi
