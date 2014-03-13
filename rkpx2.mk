# Get the long list of APNs
PRODUCT_COPY_FILES += device/rockchip/common/phone/etc/apns-full-conf.xml:system/etc/apns-conf.xml
PRODUCT_COPY_FILES += device/rockchip/common/phone/etc/spn-conf.xml:system/etc/spn-conf.xml
PRODUCT_COPY_FILES += device/rockchip/rkpx2/conf/asound_phonepad_wm8960.conf:system/etc/asound.conf
# The rkpx2 board
include device/rockchip/rkpx2/BoardConfig.mk
$(call inherit-product, device/rockchip/rkpx2/device.mk)

PRODUCT_BRAND := rockchip
PRODUCT_DEVICE := rkpx2
PRODUCT_NAME := rkpx2
PRODUCT_MODEL := rkpx2
PRODUCT_MANUFACTURER := rockchip

PRODUCT_PROPERTY_OVERRIDES += \
	ro.product.version = 1.0.0 \
	ro.product.ota.host = www.rockchip.com:2300
