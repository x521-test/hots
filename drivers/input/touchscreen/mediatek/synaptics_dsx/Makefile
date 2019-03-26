# added by Raymond Miracle on 26/3/2019
# Linux driver folder
ccflags-y += -I$(srctree)/drivers/input/touchscreen/mediatek/synaptics_dsx/
ccflags-y += -I$(srctree)/drivers/input/touchscreen/mediatek/
ccflags-y += -I$(srctree)/drivers/misc/mediatek/include/mt-plat/
ccflags-y += -I$(srctree)/drivers/misc/mediatek/include/mt-plat/$(MTK_PLATFORM)/include/

#target
obj-y +=  synaptics_dsx_rmi_dev.o
obj-y +=  synaptics_dsx_test_reporting.o
obj-y +=  synaptics_dsx_i2c.o
obj-y +=  synaptics_dsx_fw_update.o
