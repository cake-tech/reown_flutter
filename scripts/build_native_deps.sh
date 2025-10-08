#!/bin/bash
cd "$(dirname $0)"

set -x -e

if [ ! -e yttrium/.git ]; then
    rm -rf yttrium
    git clone https://github.com/cake-tech/yttrium
fi
cd yttrium
git reset --hard
git checkout 7a8b5bd01876662158db334381db8592c66952e6
git reset --hard

cargo install cargo-ndk
ENABLE_STRIP=false PROFILE=release bash -x ./build-kotlin.sh

cp target/x86_64-linux-android/release/deps/libuniffi_yttrium.so ../../packages/reown_yttrium/android/src/main/jniLibs/x86_64/libuniffi_yttrium.so
cp target/aarch64-linux-android/release/deps/libuniffi_yttrium.so ../../packages/reown_yttrium/android/src/main/jniLibs/arm64-v8a/libuniffi_yttrium.so
cp target/armv7-linux-androideabi/release/deps/libuniffi_yttrium.so ../../packages/reown_yttrium/android/src/main/jniLibs/armeabi-v7a/libuniffi_yttrium.so