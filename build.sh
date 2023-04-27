#!/bin/bash
docker build --build-arg userid=$(id -u) --build-arg groupid=$(id -g) --build-arg username=$(id -un) -t coreboot-build .

# docker run -it --rm -v $ANDROID_BUILD_TOP:/src android-build-trusty
# cd /src; source build/envsetup.sh
# lunch aosp_arm-eng
# m -j50
