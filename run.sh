#!/bin/bash
mkdir src
docker run -it --rm -v $(pwd)/src:/src coreboot-build
