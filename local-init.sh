# /bin/bash

# git version 2.55.0
git --version

# cmake version 3.24.4
cmake --version

# Python 3.14.7
python --version

# West version: v1.5.0
pip install -U west && \
  west --version
export ARMGCC_DIR="/usr"  # or your installation path

# # # Get the latest SDK from main branch:
# west init -m https://github.com/nxp-mcuxpresso/mcuxsdk-manifests.git mcuxpresso-sdk && \
# cd mcuxpresso-sdk && \
# cd manifests && \
# git pull && \
# cd .. && \
# west update_board --set board evkbmimxrt1170 && \
cd mcuxpresso-sdk && \
cd mcuxsdk && \
west build -b evkbmimxrt1170 examples/demo_apps/hello_world
#  && \
# west update && \

# # west update_board --set board aw-xm458 --list-repo && 
