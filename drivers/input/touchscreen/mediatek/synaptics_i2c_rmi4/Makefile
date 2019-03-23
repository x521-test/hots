
# Linux driver folder
ccflags-y += -I$(srctree)/drivers/input/touchscreen/mediatek/synaptics_i2c_rmi4/
ccflags-y += -I$(srctree)/drivers/input/touchscreen/mediatek/
ccflags-y += -I$(srctree)/drivers/input/touchscreen/mediatek/synaptics_i2c_rmi4/include/$(CONFIG_SYNA_RMI4_FIRMWARE)/
ccflags-y += -I$(srctree)/drivers/misc/mediatek/include/mt-plat/

#target
obj-y   +=  synaptics_driver.o
obj-y   +=  rmi_dev.o
obj-y   +=  rmi_fw_update.o
