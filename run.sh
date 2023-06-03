#!/bin/bash
# you might need to mount /src somewhere if you dont want to redownload the coreboot repo each time, ie. -v /your/dir:src
docker run -it --rm coreboot-build
