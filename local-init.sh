# /bin/bash

echo "User: $(whoami) UID: $(id -u) GID: $(id -g)"

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

export MCUXPRESSO_SDK_DIR="$SCRIPT_DIR/mcuxpresso-sdk/mcuxsdk"
export ENV_FILE="$MCUXPRESSO_SDK_DIR/mcux-env.sh"
export BOARD="evkbmimxrt1170"

case "$(uname -s)" in
Linux*)
    echo "Running on Linux"

    export ARMGCC_DIR="/opt/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi"
    export ARMGCC_GCC="$ARMGCC_DIR/bin/arm-none-eabi-gcc"

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

    ;;
  MSYS_*|MINGW*)
    echo "Running on Windows (MSYS/MSYS2)"

    export ARMGCC_DIR="$(cygpath -u $USERPROFILE)/Downloads/arm-gnu-toolchain-14.2.rel1-mingw-w64-x86_64-arm-none-eabi"
    export ARMGCC_GCC="$ARMGCC_DIR/bin/arm-none-eabi-gcc"

    export PATH="$PATH:$(cygpath -u $USERPROFILE)/Downloads/PortableGit/bin"
    export PATH="$PATH:$(cygpath -u $USERPROFILE)/Downloads/cmake-3.29.3-windows-x86_64/cmake-3.29.3-windows-x86_64/bin"
    export PYTHON_DIR="$(cygpath -u $USERPROFILE)/Downloads/python-3.13.9-amd64-portable"
    export PATH="$PATH:$PYTHON_DIR:$PYTHON_DIR/Scripts"
    export PATH="$PATH:$(cygpath -u $SYSTEMDRIVE)/Program Files/7-Zip:$(cygpath -u $SYSTEMDRIVE)/Program Files (x86)/7-Zip"

    if [ ! -f "$ARMGCC_GCC" ]; then
        echo "$ARMGCC_GCC not found. Downloading now..."

        cd "$(cygpath -u $USERPROFILE)/Downloads"; \
            cd https://gitlab.arm.com/api/v4/projects/tooling%2Fgnu-toolchains-for-arm/packages/generic/gnu-toolchain/14.2.rel1/arm-gnu-toolchain-14.2.rel1-mingw-w64-x86_64-arm-none-eabi.zip
            tar -xf arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz && \
            cd arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi && \
            ls -R
    
    else
        echo "$ARMGCC_GCC already exists. Skipping download."
    fi
    ;;
  *)
    echo "Running on a unsupported OS"
    ;;
esac

# git version 2.55.0
git --version

# cmake version 3.24.4
cmake --version

# Python 3.14.7
python --version

# West version: v1.5.0
pip install -U west && \
  west --version

if [ ! -f "$ENV_FILE" ]; then
    echo "$ENV_FILE not found. Downloading now..."

    cd "$SCRIPT_DIR" && \
    west init -m https://github.com/nxp-mcuxpresso/mcuxsdk-manifests.git "mcuxpresso-sdk"
else
    echo "$ENV_FILE already exists. Skipping download."
fi

# west update --narrow --fetch-opt=--depth=1 && \

cd "$SCRIPT_DIR/mcuxpresso-sdk" && \
west update_board --set board $BOARD && \
echo "SDK is ok"

cd "$SCRIPT_DIR" && \
source "$ENV_FILE" && \
west build -b $BOARD --sysbuild ./primary -Dcore_id=cm7 --config debug --toolchain=armgcc -p always -d cmake-build && \
echo ok

read -p "Completed"
