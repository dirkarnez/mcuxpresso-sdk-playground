# /bin/bash


SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

# git version 2.55.0
git --version

# cmake version 3.24.4
cmake --version

# Python 3.14.7
python --version

# West version: v1.5.0
pip install -U west && \
  west --version

export ARMGCC_DIR="/opt/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi"
export ARMGCC_GCC="$ARMGCC_DIR/bin/arm-none-eabi-gcc"
export MCUXPRESSO_SDK_DIR="$SCRIPT_DIR/mcuxpresso-sdk/mcuxsdk"
export ENV_FILE="$MCUXPRESSO_SDK_DIR/mcux-env.sh"
export BOARD="evkbmimxrt1170"


if [ ! -f "$ARMGCC_GCC" ]; then
    echo "$ARMGCC_GCC not found. Downloading now..."

    # /opt/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi/bin/arm-none-eabi-gcc --version
    # arm-none-eabi-gcc (Arm GNU Toolchain 14.2.Rel1 (Build arm-14.52)) 14.2.1 20241119
    cd /opt; \
      wget https://gitlab.arm.com/api/v4/projects/tooling%2Fgnu-toolchains-for-arm/packages/generic/gnu-toolchain/14.2.rel1/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz && \
      tar -xf arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz && \
      cd arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi && \
      ls -R
  
else
    echo "$ARMGCC_GCC already exists. Skipping download."
fi


if [ ! -f "$ENV_FILE" ]; then
    echo "$ENV_FILE not found. Downloading now..."
    cd $SCRIPT_DIR && \
    west init -m https://github.com/nxp-mcuxpresso/mcuxsdk-manifests.git mcuxpresso-sdk && \
    cd mcuxpresso-sdk && \
    west update_board --set board $BOARD && \
    echo "SDK is ok"
else
    echo "$ENV_FILE already exists. Skipping download."
fi

cd $SCRIPT_DIR && \
source $ENV_FILE && \
west build -b $BOARD --sysbuild ./primary -Dcore_id=cm7 --config debug --toolchain=armgcc -p always -d cmake-build && \
echo ok
