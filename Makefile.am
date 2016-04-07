ISO_NAME=CentOS-6-x86_64-custom
ISO_SOURCE_DEV=/dev/sr0
ISO_SOURCE_PATH=/tmp/source-iso
ISO_DIRS=EFI Packages images isolinux repodata ks
ISO_DIRS_COPY=EFI images isolinux
ISO_FILES_COPY= \
    .discinfo \
    .treeinfo \
    CentOS_BuildTag \
    EULA \
    RELEASE-NOTES-en-US.html \
    RPM-GPG-KEY-CentOS-Debug-6 \
    RPM-GPG-KEY-CentOS-Testing-6 \
    GPL \
    RPM-GPG-KEY-CentOS-6 \
    RPM-GPG-KEY-CentOS-Security-6
ISO_KICKSTARTERS=minimal

iso-source:
	mkdir -p $(ISO_SOURCE_PATH)
	mount $(ISO_SOURCE_DEV) $(ISO_SOURCE_PATH)
	cp -f local-dvd.repo /etc/yum.repos.d/local-dvd.repo

iso-base-structure: iso-source
	 mkdir -p $(foreach D,$(ISO_DIRS),ISO/$(D))

iso-base-files: iso-base-structure
	cp -rf $(foreach D,$(ISO_DIRS_COPY), $(ISO_SOURCE_PATH)/$(D) ) ISO/
	cp -f $(foreach F,$(ISO_FILES_COPY), $(ISO_SOURCE_PATH)/$(F)) ISO/
	cp -f $(foreach KS,$(ISO_KICKSTARTERS), ks/$(KS).ks) ISO/ks/
	yumdownloader --disablerepo=* --enablerepo=base-dvd --resolve --downloadonly --destdir=ISO/Packages --installroot=`pwd` @Core

iso-source-release:
	umount $(ISO_SOURCE_DEV)

iso-image: iso-base-files iso-source-release
	mkisofs \
	-v -U -J -R -T \
	-V "$(ISO_NAME)" \
	-A "$(ISO_NAME)" \
	-b isolinux/isolinux.bin \
	-c isolinux/boot.cat \
	-input-charset utf-8 \
	-no-emul-boot -boot-load-size 4 -boot-info-table \
	-o $(ISO_NAME).iso \
	ISO

all: iso-image

clean-local:
	rm -rf $(ISO_NAME).iso ISO configure aclocal.m4 Makefile.in config var
