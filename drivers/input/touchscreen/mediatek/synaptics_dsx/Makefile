# added by Raymond Miracle on 26/3/2019
# Linux driver folder
ccflags-y += -I$(srctree)/drivers/input/touchscreen/mediatek/synaptics_dsx/
ccflags-y += -I$(srctree)/drivers/input/touchscreen/mediatek/
ccflags-y += -I$(srctree)/drivers/misc/mediatek/include/mt-plat/

#target
obj-$(CONFIG_TOUCHSCREEN_MTK_SYNAPTICS_DSX_RMI_DEV) +=  synaptics_dsx_rmi_dev.o
obj-$(CONFIG_TOUCHSCREEN_MTK_SYNAPTICS_DSX_TEST_REPORTING) +=  synaptics_dsx_test_reporting.o
obj-$(CONFIG_TOUCHSCREEN_MTK_SYNAPTICS_DSX_I2C) +=  synaptics_dsx_i2c.o
obj-$(CONFIG_TOUCHSCREEN_MTK_SYNAPTICS_DSX_FW_UPDATE) +=  synaptics_dsx_fw_update.o
