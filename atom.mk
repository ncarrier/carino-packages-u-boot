LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := u-boot
LOCAL_CATEGORY_PATH := system

LOCAL_AUTOTOOLS_MAKE_BUILD_ARGS := \
	CROSS_COMPILE=$(TARGET_CROSS) \
	O=$(U_BOOT_BUILD_DIR)

U_BOOT_BUILD_DIR := $(call local-get-build-dir)
define LOCAL_AUTOTOOLS_CMD_CONFIGURE
	$(Q) (cd $(PRIVATE_SRC_DIR); \
	$(MAKE) CROSS_COMPILE=$(TARGET_CROSS) \
		Linksprite_pcDuino3_config \
		O=$(U_BOOT_BUILD_DIR))
endef

define LOCAL_AUTOTOOLS_CMD_BUILD
	$(Q) (cd $(PRIVATE_SRC_DIR); \
	$(MAKE) CROSS_COMPILE=$(TARGET_CROSS) \
		O=$(U_BOOT_BUILD_DIR))
endef

define LOCAL_AUTOTOOLS_CMD_INSTALL
	$(Q) mkdir -p $(TARGET_OUT_STAGING)/boot/; \
		cp $(U_BOOT_BUILD_DIR)/u-boot-sunxi-with-spl.bin \
		$(TARGET_OUT_STAGING)/boot/
endef

include $(BUILD_AUTOTOOLS)

