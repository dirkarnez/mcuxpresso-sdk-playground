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

# /opt/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi/bin/arm-none-eabi-gcc --version
# arm-none-eabi-gcc (Arm GNU Toolchain 14.2.Rel1 (Build arm-14.52)) 14.2.1 20241119
cd /opt; \
   wget https://gitlab.arm.com/api/v4/projects/tooling%2Fgnu-toolchains-for-arm/packages/generic/gnu-toolchain/14.2.rel1/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz && \
   tar -xf arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz && \
   ls

export ARMGCC_DIR="/opt/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi"

# # Get the latest SDK from main branch:
# west init -m https://github.com/nxp-mcuxpresso/mcuxsdk-manifests.git mcuxpresso-sdk && \
cd mcuxpresso-sdk && \
west update_board --set board evkbmimxrt1170 && \
cd mcuxsdk && \
west build -b evkbmimxrt1170 --sysbuild ./examples/multicore_examples/hello_world/primary -Dcore_id=cm7 --config flexspi_nor_debug --toolchain=armgcc -p always -d cmake-build && \
echo ok

# # cd manifests && \
# # git pull && \
# # cd .. && \
# # west update_board --set board evkbmimxrt1170 && \
# cd mcuxpresso-sdk && \
# cd mcuxsdk && \
# west build -b evkbmimxrt1170 examples/demo_apps/hello_world
# #  && \
# west update && \

# # west update_board --set board aw-xm458 --list-repo && 
