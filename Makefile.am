ISO_NAME=CentOS-6-x86_64
ISO_SOURCE_DEV=/dev/sr0
ISO_SOURCE_PATH=/tmp/source-iso
ISO_DIRS=EFI Packages images isolinux repodata
ISO_DIRS_COPY=EFI images isolinux
ISO_FILES_COPY= \
    CentOS_BuildTag \
    EULA \
    RELEASE-NOTES-en-US.html \
    RPM-GPG-KEY-CentOS-Debug-6 \
    RPM-GPG-KEY-CentOS-Testing-6 \
    GPL \
    RPM-GPG-KEY-CentOS-6 \
    RPM-GPG-KEY-CentOS-Security-6

iso-source:
	mkdir -p $(ISO_SOURCE_PATH)
	mount $(ISO_SOURCE_DEV) $(ISO_SOURCE_PATH)

iso-base-structure: iso-source
	 mkdir -p $(foreach D,$(ISO_DIRS),ISO/$(D))

iso-base-files: iso-base-structure
	cp -rf $(foreach D,$(ISO_DIRS_COPY), $(ISO_SOURCE_PATH)/$(D) ) ISO/
	cp -f $(foreach F,$(ISO_FILES_COPY), $(ISO_SOURCE_PATH)/$(F)) ISO/

iso-source-release:
	umount $(ISO_SOURCE_DEV)

iso-image: iso-base-files iso-source-release
	mkisofs \
	-r -T -J \
	-V "$(ISO_NAME)" \
	-b isolinux/isolinux.bin \
	-c isolinux/boot.cat \
	-no-emul-boot -boot-load-size 4 -boot-info-table \
	-o $(ISO_NAME).iso \
	ISO

all: iso-image

clean-local:
	rm -rf $(ISO_NAME).iso ISO configure aclocal.m4 Makefile.in config
