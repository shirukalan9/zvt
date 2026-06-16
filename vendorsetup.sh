#!/bin/bash

rm -rf vendor/infinix  device/xiaomi
git clone --depth=1 -b ab https://github.com/shirukalan9/zvt device/infinix/X6882
git clone --depth=1 https://github.com/shirukalan9/zvt vendor/infinix/X6882

#rm -rf vendor/mediatek hardware/transsion device/mediatek/sepolicy_vndr device/millennium/common-kernel packages/apps/GameBar

git clone --depth=1 https://github.com/MillenniumOSS/android_vendor_mediatek_ims vendor/mediatek/ims
git clone --depth=1 https://github.com/zaidannn7/hardware_transsion hardware/transsion
git clone --depth=1 https://github.com/halcyonproject/device_mediatek_sepolicy_vndr device/mediatek/sepolicy_vndr
#git clone --depth=1 https://github.com/halcyonproject/hardware_mediatek hardware/mediatek
git clone --depth=1 https://github.com/MillenniumOSS/hardware_mediatek hardware/mediatek
git clone https://github.com/MillenniumOSS/android_device_millennium_common-kernel device/millennium/common-kernel

git clone  --depth=1 https://github.com/Tanzanite-Prjkt/android_packages_apps_GameBar packages/apps/GameBar


RET=0
echo "- Applying Aperture Mediatek HFPS Mode"
cd packages/apps/Aperture
curl https://raw.githubusercontent.com/jvaswb/patches/refs/heads/sixteen/packages/apps/Aperture/0001-Aperture-Enable-MediaTek-HFPS-Mode-for-60-FPS-video-.patch | git am || {
  RET=$?
  git am --abort >/dev/null 2>&1
}
cd ../../../
echo "- Applying WPA3 Patch"
cd external/wpa_supplicant_8
curl https://raw.githubusercontent.com/jvaswb/patches/refs/heads/sixteen/external/wpa_supplicant_8/do_not_set_NL80211_WPA_VERSION_3.patch | git am || {
  RET=$?
  git am --abort >/dev/null 2>&1
}
cd ../../

if [ $RET -ne 0 ]; then
  echo "ERROR: Patch is not applied! Maybe it's already patched, or you'll have to adapt it to this specific rom source?"
else
  echo "OK: All patched"
fi

rm -rf frameworks/native
git clone --depth=1  -b ax https://github.com/shirukalan9/frameworks_native/ frameworks/native
rm -rf frameworks/base
git clone --depth=1 -b ax https://github.com/shirukalan9/frameworks_base-1 frameworks/base
rm -rf bionic
git clone --depth 1 -b lineage-23.2 https://github.com/shirukalan9/zonic bionic
rm -rf external/jemalloc_new
git clone --depth 1 -b 16.2 https://github.com/Lunaris-AOSP/external_jemalloc_new external/jemalloc_new
rm -rf build/soong
git clone --depth 1 -b lineage-23.2 https://github.com/shirukalan9/zson build/soong
rm -rf build/make
git clone --depth 1 -b lineage-23.2 https://github.com/shirukalan9/zbuilt build/make
rm -rf external/scudo
git clone --depth 1 -b patch-1 https://github.com/shirukalan9/android_external_scudo external/scudo
rm -rf art
git clone --depth 1 https://github.com/shirukalan9/android_art art

