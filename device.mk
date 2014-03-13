# Copyright (C) 2011 rockchip Limited
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Everything in this directory will become public


$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)


########################################################
# Kernel
########################################################
PRODUCT_COPY_FILES += \
    $(TARGET_PREBUILT_KERNEL):kernel


ifeq ($(strip $(BOARD_USE_LOW_MEM)), true)
include frameworks/native/build/tablet-dalvik-heap.mk
else
include frameworks/native/build/tablet-7in-hdpi-1024-dalvik-heap.mk
endif

PRODUCT_PACKAGES += WifiDisplay
PRODUCT_PACKAGES += Email
PRODUCT_PACKAGES += StressTest

#########################################################
# Copy proprietary apk
#########################################################
include device/rockchip/common/app/rkapk.mk

########################################################
# Google applications
########################################################
ifeq ($(strip $(BUILD_WITH_GOOGLE_MARKET)),true)
include vendor/google/gapps_kk_mini.mk
endif

########################################################
# Face lock
########################################################
ifeq ($(strip $(BUILD_WITH_FACELOCK)),true)
include vendor/google/facelock.mk
endif

PRODUCT_COPY_FILES += \
    device/rockchip/rkpx2/init/init.rc:root/init.rc \
    device/rockchip/rkpx2/init/init.environ.rc:root/init.environ.rc \
    device/rockchip/rkpx2/init/init.$(TARGET_BOARD_HARDWARE).rc:root/init.$(TARGET_BOARD_HARDWARE).rc \
    device/rockchip/rkpx2/init/init.$(TARGET_BOARD_HARDWARE).usb.rc:root/init.$(TARGET_BOARD_HARDWARE).usb.rc \
    $(call add-to-product-copy-files-if-exists,device/rockchip/rkpx2/init/init.$(TARGET_BOARD_HARDWARE).bootmode.emmc.rc:root/init.$(TARGET_BOARD_HARDWARE).bootmode.emmc.rc) \
    $(call add-to-product-copy-files-if-exists,device/rockchip/rkpx2/init/init.$(TARGET_BOARD_HARDWARE).bootmode.unknown.rc:root/init.$(TARGET_BOARD_HARDWARE).bootmode.unknown.rc) \
    device/rockchip/rkpx2/init/ueventd.$(TARGET_BOARD_HARDWARE).rc:root/ueventd.$(TARGET_BOARD_HARDWARE).rc \
    device/rockchip/rkpx2/conf/media_profiles_default.xml:system/etc/media_profiles_default.xml \
    device/rockchip/rkpx2/conf/rk29-keypad.kl:system/usr/keylayout/rk29-keypad.kl

PRODUCT_COPY_FILES += \
    hardware/broadcom/wlan/bcmdhd/config/wpa_supplicant_overlay.conf:system/etc/wifi/wpa_supplicant_overlay.conf \
    hardware/broadcom/wlan/bcmdhd/config/p2p_supplicant_overlay.conf:system/etc/wifi/p2p_supplicant_overlay.conf

ifneq ($(strip $(BOARD_CONNECTIVITY_VENDOR)), MediaTek)
ifneq ($(strip $(BOARD_CONNECTIVITY_VENDOR)), RealTek)
PRODUCT_COPY_FILES += \
    device/rockchip/rkpx2/init/init.connectivity.rc:root/init.connectivity.rc
endif
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/conf/audio_policy.conf:system/etc/audio_policy.conf


PRODUCT_COPY_FILES += \
    device/rockchip/rkpx2/conf/fstab.$(TARGET_BOARD_HARDWARE).bootmode.unknown:root/fstab.$(TARGET_BOARD_HARDWARE).bootmode.unknown \
    device/rockchip/rkpx2/conf/fstab.$(TARGET_BOARD_HARDWARE).bootmode.emmc:root/fstab.$(TARGET_BOARD_HARDWARE).bootmode.emmc

# For audio-recoard 
PRODUCT_PACKAGES += \
    libsrec_jni

include device/rockchip/common/gpu/rkpx2_gpu.mk
include device/rockchip/common/vpu/rkpx2_vpu.mk
include device/rockchip/common/wifi/rk30_wifi.mk
include device/rockchip/common/nand/rk30_nand.mk

include device/rockchip/common/bin/rkpx2_bin.mk
include device/rockchip/common/webkit/rk31_webkit.mk
ifeq ($(strip $(BOARD_HAVE_BLUETOOTH)),true)
    include device/rockchip/common/bluetooth/rk30_bt.mk
endif
include device/rockchip/common/app/rkupdateservice.mk
include device/rockchip/common/app/rkUserExperienceService.mk
include device/rockchip/common/etc/adblock.mk

# uncomment the line bellow to enable phone functions
include device/rockchip/common/phone/rk30_phone.mk

include device/rockchip/common/features/rk-core.mk
include device/rockchip/common/features/rk-camera.mk
include device/rockchip/common/features/rk-camera-front.mk
include device/rockchip/common/features/rk-gms.mk

# Live Wallpapers
PRODUCT_PACKAGES += \
    LiveWallpapersPicker \
    NoiseField \
    PhaseBeam \
    librs_jni \
    libjni_pinyinime \
    hostapd_rtl

# HAL
PRODUCT_PACKAGES += \
    power.$(TARGET_BOARD_PLATFORM) \
    sensors.$(TARGET_BOARD_HARDWARE) \
    gralloc.$(TARGET_BOARD_HARDWARE) \
    hwcomposer.$(TARGET_BOARD_HARDWARE) \
    lights.$(TARGET_BOARD_HARDWARE) \
    camera.$(TARGET_BOARD_HARDWARE) \
    libMcClient \
    mcDriverDaemon \
    keystore.$(TARGET_BOARD_PLATFORM) \
    Camera \
    akmd 

# charge
PRODUCT_PACKAGES += \
    charger \
    charger_res_images 


PRODUCT_CHARACTERISTICS := tablet

# audio lib
PRODUCT_PACKAGES += \
    audio_policy.$(TARGET_BOARD_HARDWARE) \
    audio.primary.$(TARGET_BOARD_HARDWARE) \
    audio.alsa_usb.$(TARGET_BOARD_HARDWARE) \
    audio.a2dp.default\
    audio.r_submix.default\
    audio.usb.default

# Filesystem management tools
# EXT3/4 support
PRODUCT_PACKAGES += \
    mke2fs \
    e2fsck \
    tune2fs \
    resize2fs \
    mkdosfs

# audio lib
PRODUCT_PACKAGES += \
    libasound \
    alsa.default \
    acoustics.default \
    libtinyalsa

PRODUCT_PACKAGES += \
	alsa.audio.primary.$(TARGET_BOARD_HARDWARE)\
	alsa.audio_policy.$(TARGET_BOARD_HARDWARE)

$(call inherit-product-if-exists, external/alsa-lib/copy.mk)
$(call inherit-product-if-exists, external/alsa-utils/copy.mk)


PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.strictmode.visual=false \
    dalvik.vm.jniopts=warnonly

ifeq ($(strip $(BUILD_WITH_CRYPTO)),true)
    PRODUCT_PROPERTY_OVERRIDES += ro.crypto.state=unencrypted
endif

ifeq ($(strip $(BOARD_HAVE_BLUETOOTH)),true)
    PRODUCT_PROPERTY_OVERRIDES += ro.rk.bt_enable=true
else
    PRODUCT_PROPERTY_OVERRIDES += ro.rk.bt_enable=false
endif

ifeq ($(strip $(MT6622_BT_SUPPORT)),true)
    PRODUCT_PROPERTY_OVERRIDES += ro.rk.btchip=mt6622
endif

ifeq ($(strip $(BLUETOOTH_USE_BPLUS)),true)
    PRODUCT_PROPERTY_OVERRIDES += ro.rk.btchip=broadcom.bplus
endif

ifeq ($(strip $(MT7601U_WIFI_SUPPORT)),true)
    PRODUCT_PROPERTY_OVERRIDES += ro.rk.wifichip=mt7601u
endif


PRODUCT_TAGS += dalvik.gc.type-precise


########################################################
# build with UMS?
########################################################
ifeq ($(strip $(BUILD_WITH_UMS)),true)
	PRODUCT_PROPERTY_OVERRIDES += \
		ro.factory.hasUMS=true \
		persist.sys.usb.config=mass_storage,adb 
       		#testing.mediascanner.skiplist = /mnt/internal_sd/Android/


	PRODUCT_COPY_FILES += \
		device/rockchip/rkpx2/init/init.$(TARGET_BOARD_HARDWARE).hasUMS.true.rc:root/init.$(TARGET_BOARD_HARDWARE).environment.rc
else
	PRODUCT_PROPERTY_OVERRIDES += \
		ro.factory.hasUMS=false \
		persist.sys.usb.config=mtp,adb 
       		#testing.mediascanner.skiplist = /mnt/shell/emulated/Android/

        PRODUCT_COPY_FILES += \
                device/rockchip/rkpx2/init/init.$(TARGET_BOARD_HARDWARE).hasUMS.false.rc:root/init.$(TARGET_BOARD_HARDWARE).environment.rc
endif

########################################################
# build with drmservice
########################################################
ifeq ($(strip $(BUILD_WITH_DRMSERVICE)),true)
	PRODUCT_PACKAGES += \
	               drmservice
endif



########################################################
# this product has GPS or not
########################################################
ifeq ($(strip $(BOARD_HAS_GPS)),true)
	PRODUCT_PROPERTY_OVERRIDES += \
		ro.factory.hasGPS=true
else
	PRODUCT_PROPERTY_OVERRIDES += \
		ro.factory.hasGPS=false
endif

########################################################
# this product has Ethernet or not
########################################################
ifneq ($(strip $(BOARD_HS_ETHERNET)),true)
    PRODUCT_PROPERTY_OVERRIDES += ro.rk.ethernet_enable=false
endif

#######################################################
#build system support ntfs?
########################################################
ifeq ($(strip $(BOARD_IS_SUPPORT_NTFS)),true)
     PRODUCT_PROPERTY_OVERRIDES += \
         ro.factory.storage_suppntfs=true
else
     PRODUCT_PROPERTY_OVERRIDES += \
         ro.factory.storage_suppntfs=false
endif
 
# NTFS support
PRODUCT_PACKAGES += \
    ntfs-3g

PRODUCT_PACKAGES += \
    com.android.future.usb.accessory

PRODUCT_PACKAGES += \
    librecovery_ui_$(TARGET_PRODUCT)

# for bugreport
ifneq ($(TARGET_BUILD_VARIANT),user)
    PRODUCT_COPY_FILES += device/rockchip/rkpx2/bugreport.sh:system/bin/bugreport.sh
endif


ifeq ($(strip $(BOARD_BOOT_READAHEAD)),true)
    PRODUCT_COPY_FILES += \
        $(LOCAL_PATH)/proprietary/readahead/readahead:root/sbin/readahead \
        $(LOCAL_PATH)/proprietary/readahead/readahead_list.txt:root/readahead_list.txt
endif
    
# for data clone
include device/rockchip/common/data_clone/packdata.mk

$(call inherit-product, external/wlan_loader/wifi-firmware.mk)

ifeq ($(strip $(BOARD_CONNECTIVITY_VENDOR)), MediaTek)
ifeq ($(strip $(BOARD_CONNECTIVITY_MODULE)), combo_mt66xx)
$(call inherit-product, hardware/mediatek/config/$(strip $(BOARD_CONNECTIVITY_MODULE))/product_package.mk)
endif
ifeq ($(strip $(BOARD_CONNECTIVITY_MODULE)), mt5931_6622)
$(call inherit-product, hardware/mediatek/config/$(strip $(BOARD_CONNECTIVITY_MODULE))/product_package.mk)
endif
endif

ifeq ($(strip $(BOARD_CONNECTIVITY_VENDOR)), RealTek)
include hardware/realtek/wlan/config/config-rtl.mk
endif
